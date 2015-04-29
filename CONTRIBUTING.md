Contributing
============

Contributions to ExAws are absolutely appreciated. For general bug fixes or other tweaks to existing code, a regular pull request is fine. For those who wish to add to the set of APIs supported by ExAws, please consult Organization section, as any PRs adding a service are expected to follow the structure defined therein.

## Organization

If you're the kind of person who learns best by example, it may help to read the Example section below first.

For a given service, the following basic files and modules exist:
```
lib/ex_aws/service_name.ex         #=> ExAws.ServiceName
lib/ex_aws/service_name/client.ex  #=> ExAws.ServiceName.Client
lib/ex_aws/service_name/impl.ex    #=> ExAws.ServiceName.Impl
lib/ex_aws/service_name/request.ex #=> ExAws.ServiceName.Request
```

### ExAws.ServiceName.Request

Consists of a `request` function and any custom request logic required for a given API. This may include particular headers that service expects, url formatting, etc. It should not include the authorization header signing process, as this is handled by the ExAws.Request module. The request function ought to call `ExAws.Request.request/5`.

### ExAws.ServiceName.Impl

houses the functions that correspond to a particular action in the AWS service. Function names should correspond as closely as is reasonable to the AWS action they implement. All functions in this module (excluding any private helpers) MUST accept a client as the first argument, and call the client.request function with whatever relevant data exists for that action.

### ExAws.ServiceName.Client

This module serves several  rolls. The first is to hold all of the callbacks that must be implemented by a given client. The second is to define a __using__ macro that implements all of the aforementioned callbacks. The body of each function ought to consist exclusively of simply calling the corresponding function in the Impl module with `__MODULE__` as the first argument. The macro should also include a request function that simply passes the arguments to the function in the Request module. This indirection exists so that users with custom clients can specify custom behaviour around a request by overriding this function in their client module.

Finally, this module specifies the default way in which configuration is to be found. This is basically the same for every service. Why not meta-program away the repetition? I figured two layers of macros ought to be avoided, particularly since this isn't very much code. See any of the existing clients for details.

### ExAws.ServiceName
Finally, the bare ExAws.ServiceName ought to simply consist of the following.
```elixir
defmodule ExAws.ServiceName do
  use ExAws.ServiceName.Client

  def config_root, do: Application.get_all_env(:ex_aws)
end
```
This produces a reified default client for the service in question.

## Example
To make all of this concrete, let's take a look at the `Dynamo.describe_table` function.

ExAws.Dynamo.Client specifies the callback

```elixir
defcallback describe_table(name :: binary) :: ExAws.Request.response_t
```

Additionally, it defines a __using__ macro that implements this function (shown here truncated) and also a request function
```elixir
defmacro __using__(_) do
  quote do
    def describe_table(name) do
      ExAws.Dynamo.Impl.describe_table(__MODULE__, name)
    end

    def request(data, action) do
      ExAws.Dynamo.Request.request(__MODULE__, action, data)
    end
  end
end
```
The macro ought never to do more than call the corresponding function in Impl with __MODULE__ added as the first argument. Lots of logic inside macros can become rapidly challenging to test.

Now we hop over to the `ExAws.Dynamo.Impl` module where we actually format the request:
```elixir
def describe_table(client, name) do
  %{TableName: name}
  |> client.request(:describe_table)
end
```
You're probably wondering, why are we going to the effort of calling client.request when all it does is just pass things along to ExAws.Dynamo.Request? Good question! This pattern bestows some very useful abilities upon custom clients. Suppose for example you had staging and production Dynamo tables such that you had a Users-staging and Users-production table, and some STAGE environment variable to tell the app what stage it's in. Instead of the tedious and bug prone `"Users-#{System.get_env("STAGE")}" |> Dynamo.describe_table`, you can just override the request function in a custom client. For example:

```elixir
defmodule My.Dynamo do
  def request(%{TableName: table_name} = data, action) do
    data = %{data | TableName: "#{table_name}-#{System.get_env("STAGE")}"}

    ExAws.Dynamo.Request.request(__MODULE__, action, data)
  end
  def request(data, action), do: super(data, action)
end
```

And there we go. Now we can simply do `My.Dynamo.describe_table("Users")` and it will automatically handle the stage question for us\*\*

In any case, `ExAws.Dynamo.Request.request/3` is called by our client and handles dynamo specific headers, and to use the configuration associated with our client to build the URL to hit. We finally end up in `ExAws.Request.request/5` where the configuration for our client is used to retrieve AWS keys and so forth.

Lastly we have our `ExAws.Dynamo` module which uses the `ExAws.Dynamo.Client` to become a reified client.

\*\**DISCLAIMER* This is NOT a replacement for or even in the same category as proper AWS security practices. The keys used by your staging and production instances ought to be different, with sufficiently restrictive security policies such that the staging keys can only touch *-staging tables and so on. This functionality exists to minimize bugs and boilerplate, not replace actual security practices.
