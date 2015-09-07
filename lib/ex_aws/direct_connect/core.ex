defmodule ExAws.DirectConnect.Core do
  import ExAws.Core.JSON, only: [format_input: 1]
  @actions [
    "AllocateConnectionOnInterconnect",
    "AllocatePrivateVirtualInterface",
    "AllocatePublicVirtualInterface",
    "ConfirmConnection",
    "ConfirmPrivateVirtualInterface",
    "ConfirmPublicVirtualInterface",
    "CreateConnection",
    "CreateInterconnect",
    "CreatePrivateVirtualInterface",
    "CreatePublicVirtualInterface",
    "DeleteConnection",
    "DeleteInterconnect",
    "DeleteVirtualInterface",
    "DescribeConnections",
    "DescribeConnectionsOnInterconnect",
    "DescribeInterconnects",
    "DescribeLocations",
    "DescribeVirtualGateways",
    "DescribeVirtualInterfaces"]

  @moduledoc """
  ## AWS Direct Connect

  AWS Direct Connect makes it easy to establish a dedicated network
  connection from your premises to Amazon Web Services (AWS). Using AWS
  Direct Connect, you can establish private connectivity between AWS and your
  data center, office, or colocation environment, which in many cases can
  reduce your network costs, increase bandwidth throughput, and provide a
  more consistent network experience than Internet-based connections.

  The AWS Direct Connect API Reference provides descriptions, syntax, and
  usage examples for each of the actions and data types for AWS Direct
  Connect. Use the following links to get started using the *AWS Direct
  Connect API Reference*:

  -
  [Actions](http://docs.aws.amazon.com/directconnect/latest/APIReference/API_Operations.html):
  An alphabetical list of all AWS Direct Connect actions.

  - [Data
  Types](http://docs.aws.amazon.com/directconnect/latest/APIReference/API_Types.html):
  An alphabetical list of all AWS Direct Connect data types.

  - [Common Query
  Parameters](http://docs.aws.amazon.com/directconnect/latest/APIReference/CommonParameters.html):
  Parameters that all Query actions can use.

  - [Common
  Errors](http://docs.aws.amazon.com/directconnect/latest/APIReference/CommonErrors.html):
  Client and server errors that all actions can return.
  """

  @type asn :: integer

  @type allocate_connection_on_interconnect_request :: [
    bandwidth: bandwidth,
    connection_name: connection_name,
    interconnect_id: interconnect_id,
    owner_account: owner_account,
    vlan: vlan,
  ]

  @type allocate_private_virtual_interface_request :: [
    connection_id: connection_id,
    new_private_virtual_interface_allocation: new_private_virtual_interface_allocation,
    owner_account: owner_account,
  ]

  @type allocate_public_virtual_interface_request :: [
    connection_id: connection_id,
    new_public_virtual_interface_allocation: new_public_virtual_interface_allocation,
    owner_account: owner_account,
  ]

  @type amazon_address :: binary

  @type bgp_auth_key :: binary

  @type bandwidth :: binary

  @type cidr :: binary

  @type confirm_connection_request :: [
    connection_id: connection_id,
  ]

  @type confirm_connection_response :: [
    connection_state: connection_state,
  ]

  @type confirm_private_virtual_interface_request :: [
    virtual_gateway_id: virtual_gateway_id,
    virtual_interface_id: virtual_interface_id,
  ]

  @type confirm_private_virtual_interface_response :: [
    virtual_interface_state: virtual_interface_state,
  ]

  @type confirm_public_virtual_interface_request :: [
    virtual_interface_id: virtual_interface_id,
  ]

  @type confirm_public_virtual_interface_response :: [
    virtual_interface_state: virtual_interface_state,
  ]

  @type connection :: [
    bandwidth: bandwidth,
    connection_id: connection_id,
    connection_name: connection_name,
    connection_state: connection_state,
    location: location_code,
    owner_account: owner_account,
    partner_name: partner_name,
    region: region,
    vlan: vlan,
  ]

  @type connection_id :: binary

  @type connection_list :: [connection]

  @type connection_name :: binary

  @type connection_state :: binary

  @type connections :: [
    connections: connection_list,
  ]

  @type create_connection_request :: [
    bandwidth: bandwidth,
    connection_name: connection_name,
    location: location_code,
  ]

  @type create_interconnect_request :: [
    bandwidth: bandwidth,
    interconnect_name: interconnect_name,
    location: location_code,
  ]

  @type create_private_virtual_interface_request :: [
    connection_id: connection_id,
    new_private_virtual_interface: new_private_virtual_interface,
  ]

  @type create_public_virtual_interface_request :: [
    connection_id: connection_id,
    new_public_virtual_interface: new_public_virtual_interface,
  ]

  @type customer_address :: binary

  @type delete_connection_request :: [
    connection_id: connection_id,
  ]

  @type delete_interconnect_request :: [
    interconnect_id: interconnect_id,
  ]

  @type delete_interconnect_response :: [
    interconnect_state: interconnect_state,
  ]

  @type delete_virtual_interface_request :: [
    virtual_interface_id: virtual_interface_id,
  ]

  @type delete_virtual_interface_response :: [
    virtual_interface_state: virtual_interface_state,
  ]

  @type describe_connections_on_interconnect_request :: [
    interconnect_id: interconnect_id,
  ]

  @type describe_connections_request :: [
    connection_id: connection_id,
  ]

  @type describe_interconnects_request :: [
    interconnect_id: interconnect_id,
  ]

  @type describe_virtual_interfaces_request :: [
    connection_id: connection_id,
    virtual_interface_id: virtual_interface_id,
  ]

  @type direct_connect_client_exception :: [
    message: error_message,
  ]

  @type direct_connect_server_exception :: [
    message: error_message,
  ]

  @type error_message :: binary

  @type interconnect :: [
    bandwidth: bandwidth,
    interconnect_id: interconnect_id,
    interconnect_name: interconnect_name,
    interconnect_state: interconnect_state,
    location: location_code,
    region: region,
  ]

  @type interconnect_id :: binary

  @type interconnect_list :: [interconnect]

  @type interconnect_name :: binary

  @type interconnect_state :: binary

  @type interconnects :: [
    interconnects: interconnect_list,
  ]

  @type location :: [
    location_code: location_code,
    location_name: location_name,
  ]

  @type location_code :: binary

  @type location_list :: [location]

  @type location_name :: binary

  @type locations :: [
    locations: location_list,
  ]

  @type new_private_virtual_interface :: [
    amazon_address: amazon_address,
    asn: asn,
    auth_key: bgp_auth_key,
    customer_address: customer_address,
    virtual_gateway_id: virtual_gateway_id,
    virtual_interface_name: virtual_interface_name,
    vlan: vlan,
  ]

  @type new_private_virtual_interface_allocation :: [
    amazon_address: amazon_address,
    asn: asn,
    auth_key: bgp_auth_key,
    customer_address: customer_address,
    virtual_interface_name: virtual_interface_name,
    vlan: vlan,
  ]

  @type new_public_virtual_interface :: [
    amazon_address: amazon_address,
    asn: asn,
    auth_key: bgp_auth_key,
    customer_address: customer_address,
    route_filter_prefixes: route_filter_prefix_list,
    virtual_interface_name: virtual_interface_name,
    vlan: vlan,
  ]

  @type new_public_virtual_interface_allocation :: [
    amazon_address: amazon_address,
    asn: asn,
    auth_key: bgp_auth_key,
    customer_address: customer_address,
    route_filter_prefixes: route_filter_prefix_list,
    virtual_interface_name: virtual_interface_name,
    vlan: vlan,
  ]

  @type owner_account :: binary

  @type partner_name :: binary

  @type region :: binary

  @type route_filter_prefix :: [
    cidr: cidr,
  ]

  @type route_filter_prefix_list :: [route_filter_prefix]

  @type router_config :: binary

  @type vlan :: integer

  @type virtual_gateway :: [
    virtual_gateway_id: virtual_gateway_id,
    virtual_gateway_state: virtual_gateway_state,
  ]

  @type virtual_gateway_id :: binary

  @type virtual_gateway_list :: [virtual_gateway]

  @type virtual_gateway_state :: binary

  @type virtual_gateways :: [
    virtual_gateways: virtual_gateway_list,
  ]

  @type virtual_interface :: [
    amazon_address: amazon_address,
    asn: asn,
    auth_key: bgp_auth_key,
    connection_id: connection_id,
    customer_address: customer_address,
    customer_router_config: router_config,
    location: location_code,
    owner_account: owner_account,
    route_filter_prefixes: route_filter_prefix_list,
    virtual_gateway_id: virtual_gateway_id,
    virtual_interface_id: virtual_interface_id,
    virtual_interface_name: virtual_interface_name,
    virtual_interface_state: virtual_interface_state,
    virtual_interface_type: virtual_interface_type,
    vlan: vlan,
  ]

  @type virtual_interface_id :: binary

  @type virtual_interface_list :: [virtual_interface]

  @type virtual_interface_name :: binary

  @type virtual_interface_state :: binary

  @type virtual_interface_type :: binary

  @type virtual_interfaces :: [
    virtual_interfaces: virtual_interface_list,
  ]





  @doc """
  AllocateConnectionOnInterconnect

  Creates a hosted connection on an interconnect.

  Allocates a VLAN number and a specified amount of bandwidth for use by a
  hosted connection on the given interconnect.
  """

  @spec allocate_connection_on_interconnect(client :: ExAws.DirectConnect.t, input :: allocate_connection_on_interconnect_request) :: ExAws.Request.JSON.response_t
  def allocate_connection_on_interconnect(client, input) do
    request(client, "AllocateConnectionOnInterconnect", format_input(input))
  end

  @doc """
  Same as `allocate_connection_on_interconnect/2` but raise on error.
  """
  @spec allocate_connection_on_interconnect!(client :: ExAws.DirectConnect.t, input :: allocate_connection_on_interconnect_request) :: ExAws.Request.JSON.success_t | no_return
  def allocate_connection_on_interconnect!(client, input) do
    case allocate_connection_on_interconnect(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  AllocatePrivateVirtualInterface

  Provisions a private virtual interface to be owned by a different customer.

  The owner of a connection calls this function to provision a private
  virtual interface which will be owned by another AWS customer.

  Virtual interfaces created using this function must be confirmed by the
  virtual interface owner by calling ConfirmPrivateVirtualInterface. Until
  this step has been completed, the virtual interface will be in 'Confirming'
  state, and will not be available for handling traffic.
  """

  @spec allocate_private_virtual_interface(client :: ExAws.DirectConnect.t, input :: allocate_private_virtual_interface_request) :: ExAws.Request.JSON.response_t
  def allocate_private_virtual_interface(client, input) do
    request(client, "AllocatePrivateVirtualInterface", format_input(input))
  end

  @doc """
  Same as `allocate_private_virtual_interface/2` but raise on error.
  """
  @spec allocate_private_virtual_interface!(client :: ExAws.DirectConnect.t, input :: allocate_private_virtual_interface_request) :: ExAws.Request.JSON.success_t | no_return
  def allocate_private_virtual_interface!(client, input) do
    case allocate_private_virtual_interface(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  AllocatePublicVirtualInterface

  Provisions a public virtual interface to be owned by a different customer.

  The owner of a connection calls this function to provision a public virtual
  interface which will be owned by another AWS customer.

  Virtual interfaces created using this function must be confirmed by the
  virtual interface owner by calling ConfirmPublicVirtualInterface. Until
  this step has been completed, the virtual interface will be in 'Confirming'
  state, and will not be available for handling traffic.
  """

  @spec allocate_public_virtual_interface(client :: ExAws.DirectConnect.t, input :: allocate_public_virtual_interface_request) :: ExAws.Request.JSON.response_t
  def allocate_public_virtual_interface(client, input) do
    request(client, "AllocatePublicVirtualInterface", format_input(input))
  end

  @doc """
  Same as `allocate_public_virtual_interface/2` but raise on error.
  """
  @spec allocate_public_virtual_interface!(client :: ExAws.DirectConnect.t, input :: allocate_public_virtual_interface_request) :: ExAws.Request.JSON.success_t | no_return
  def allocate_public_virtual_interface!(client, input) do
    case allocate_public_virtual_interface(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ConfirmConnection

  Confirm the creation of a hosted connection on an interconnect.

  Upon creation, the hosted connection is initially in the 'Ordering' state,
  and will remain in this state until the owner calls ConfirmConnection to
  confirm creation of the hosted connection.
  """

  @spec confirm_connection(client :: ExAws.DirectConnect.t, input :: confirm_connection_request) :: ExAws.Request.JSON.response_t
  def confirm_connection(client, input) do
    request(client, "ConfirmConnection", format_input(input))
  end

  @doc """
  Same as `confirm_connection/2` but raise on error.
  """
  @spec confirm_connection!(client :: ExAws.DirectConnect.t, input :: confirm_connection_request) :: ExAws.Request.JSON.success_t | no_return
  def confirm_connection!(client, input) do
    case confirm_connection(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ConfirmPrivateVirtualInterface

  Accept ownership of a private virtual interface created by another
  customer.

  After the virtual interface owner calls this function, the virtual
  interface will be created and attached to the given virtual private
  gateway, and will be available for handling traffic.
  """

  @spec confirm_private_virtual_interface(client :: ExAws.DirectConnect.t, input :: confirm_private_virtual_interface_request) :: ExAws.Request.JSON.response_t
  def confirm_private_virtual_interface(client, input) do
    request(client, "ConfirmPrivateVirtualInterface", format_input(input))
  end

  @doc """
  Same as `confirm_private_virtual_interface/2` but raise on error.
  """
  @spec confirm_private_virtual_interface!(client :: ExAws.DirectConnect.t, input :: confirm_private_virtual_interface_request) :: ExAws.Request.JSON.success_t | no_return
  def confirm_private_virtual_interface!(client, input) do
    case confirm_private_virtual_interface(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ConfirmPublicVirtualInterface

  Accept ownership of a public virtual interface created by another customer.

  After the virtual interface owner calls this function, the specified
  virtual interface will be created and made available for handling traffic.
  """

  @spec confirm_public_virtual_interface(client :: ExAws.DirectConnect.t, input :: confirm_public_virtual_interface_request) :: ExAws.Request.JSON.response_t
  def confirm_public_virtual_interface(client, input) do
    request(client, "ConfirmPublicVirtualInterface", format_input(input))
  end

  @doc """
  Same as `confirm_public_virtual_interface/2` but raise on error.
  """
  @spec confirm_public_virtual_interface!(client :: ExAws.DirectConnect.t, input :: confirm_public_virtual_interface_request) :: ExAws.Request.JSON.success_t | no_return
  def confirm_public_virtual_interface!(client, input) do
    case confirm_public_virtual_interface(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateConnection

  Creates a new connection between the customer network and a specific AWS
  Direct Connect location.

  A connection links your internal network to an AWS Direct Connect location
  over a standard 1 gigabit or 10 gigabit Ethernet fiber-optic cable. One end
  of the cable is connected to your router, the other to an AWS Direct
  Connect router. An AWS Direct Connect location provides access to Amazon
  Web Services in the region it is associated with. You can establish
  connections with AWS Direct Connect locations in multiple regions, but a
  connection in one region does not provide connectivity to other regions.
  """

  @spec create_connection(client :: ExAws.DirectConnect.t, input :: create_connection_request) :: ExAws.Request.JSON.response_t
  def create_connection(client, input) do
    request(client, "CreateConnection", format_input(input))
  end

  @doc """
  Same as `create_connection/2` but raise on error.
  """
  @spec create_connection!(client :: ExAws.DirectConnect.t, input :: create_connection_request) :: ExAws.Request.JSON.success_t | no_return
  def create_connection!(client, input) do
    case create_connection(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateInterconnect

  Creates a new interconnect between a AWS Direct Connect partner's network
  and a specific AWS Direct Connect location.

  An interconnect is a connection which is capable of hosting other
  connections. The AWS Direct Connect partner can use an interconnect to
  provide sub-1Gbps AWS Direct Connect service to tier 2 customers who do not
  have their own connections. Like a standard connection, an interconnect
  links the AWS Direct Connect partner's network to an AWS Direct Connect
  location over a standard 1 Gbps or 10 Gbps Ethernet fiber-optic cable. One
  end is connected to the partner's router, the other to an AWS Direct
  Connect router.

  For each end customer, the AWS Direct Connect partner provisions a
  connection on their interconnect by calling
  AllocateConnectionOnInterconnect. The end customer can then connect to AWS
  resources by creating a virtual interface on their connection, using the
  VLAN assigned to them by the AWS Direct Connect partner.
  """

  @spec create_interconnect(client :: ExAws.DirectConnect.t, input :: create_interconnect_request) :: ExAws.Request.JSON.response_t
  def create_interconnect(client, input) do
    request(client, "CreateInterconnect", format_input(input))
  end

  @doc """
  Same as `create_interconnect/2` but raise on error.
  """
  @spec create_interconnect!(client :: ExAws.DirectConnect.t, input :: create_interconnect_request) :: ExAws.Request.JSON.success_t | no_return
  def create_interconnect!(client, input) do
    case create_interconnect(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreatePrivateVirtualInterface

  Creates a new private virtual interface. A virtual interface is the VLAN
  that transports AWS Direct Connect traffic. A private virtual interface
  supports sending traffic to a single virtual private cloud (VPC).
  """

  @spec create_private_virtual_interface(client :: ExAws.DirectConnect.t, input :: create_private_virtual_interface_request) :: ExAws.Request.JSON.response_t
  def create_private_virtual_interface(client, input) do
    request(client, "CreatePrivateVirtualInterface", format_input(input))
  end

  @doc """
  Same as `create_private_virtual_interface/2` but raise on error.
  """
  @spec create_private_virtual_interface!(client :: ExAws.DirectConnect.t, input :: create_private_virtual_interface_request) :: ExAws.Request.JSON.success_t | no_return
  def create_private_virtual_interface!(client, input) do
    case create_private_virtual_interface(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreatePublicVirtualInterface

  Creates a new public virtual interface. A virtual interface is the VLAN
  that transports AWS Direct Connect traffic. A public virtual interface
  supports sending traffic to public services of AWS such as Amazon Simple
  Storage Service (Amazon S3).
  """

  @spec create_public_virtual_interface(client :: ExAws.DirectConnect.t, input :: create_public_virtual_interface_request) :: ExAws.Request.JSON.response_t
  def create_public_virtual_interface(client, input) do
    request(client, "CreatePublicVirtualInterface", format_input(input))
  end

  @doc """
  Same as `create_public_virtual_interface/2` but raise on error.
  """
  @spec create_public_virtual_interface!(client :: ExAws.DirectConnect.t, input :: create_public_virtual_interface_request) :: ExAws.Request.JSON.success_t | no_return
  def create_public_virtual_interface!(client, input) do
    case create_public_virtual_interface(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteConnection

  Deletes the connection.

  Deleting a connection only stops the AWS Direct Connect port hour and data
  transfer charges. You need to cancel separately with the providers any
  services or charges for cross-connects or network circuits that connect you
  to the AWS Direct Connect location.
  """

  @spec delete_connection(client :: ExAws.DirectConnect.t, input :: delete_connection_request) :: ExAws.Request.JSON.response_t
  def delete_connection(client, input) do
    request(client, "DeleteConnection", format_input(input))
  end

  @doc """
  Same as `delete_connection/2` but raise on error.
  """
  @spec delete_connection!(client :: ExAws.DirectConnect.t, input :: delete_connection_request) :: ExAws.Request.JSON.success_t | no_return
  def delete_connection!(client, input) do
    case delete_connection(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteInterconnect

  Deletes the specified interconnect.
  """

  @spec delete_interconnect(client :: ExAws.DirectConnect.t, input :: delete_interconnect_request) :: ExAws.Request.JSON.response_t
  def delete_interconnect(client, input) do
    request(client, "DeleteInterconnect", format_input(input))
  end

  @doc """
  Same as `delete_interconnect/2` but raise on error.
  """
  @spec delete_interconnect!(client :: ExAws.DirectConnect.t, input :: delete_interconnect_request) :: ExAws.Request.JSON.success_t | no_return
  def delete_interconnect!(client, input) do
    case delete_interconnect(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteVirtualInterface

  Deletes a virtual interface.
  """

  @spec delete_virtual_interface(client :: ExAws.DirectConnect.t, input :: delete_virtual_interface_request) :: ExAws.Request.JSON.response_t
  def delete_virtual_interface(client, input) do
    request(client, "DeleteVirtualInterface", format_input(input))
  end

  @doc """
  Same as `delete_virtual_interface/2` but raise on error.
  """
  @spec delete_virtual_interface!(client :: ExAws.DirectConnect.t, input :: delete_virtual_interface_request) :: ExAws.Request.JSON.success_t | no_return
  def delete_virtual_interface!(client, input) do
    case delete_virtual_interface(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeConnections

  Displays all connections in this region.

  If a connection ID is provided, the call returns only that particular
  connection.
  """

  @spec describe_connections(client :: ExAws.DirectConnect.t, input :: describe_connections_request) :: ExAws.Request.JSON.response_t
  def describe_connections(client, input) do
    request(client, "DescribeConnections", format_input(input))
  end

  @doc """
  Same as `describe_connections/2` but raise on error.
  """
  @spec describe_connections!(client :: ExAws.DirectConnect.t, input :: describe_connections_request) :: ExAws.Request.JSON.success_t | no_return
  def describe_connections!(client, input) do
    case describe_connections(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeConnectionsOnInterconnect

  Return a list of connections that have been provisioned on the given
  interconnect.
  """

  @spec describe_connections_on_interconnect(client :: ExAws.DirectConnect.t, input :: describe_connections_on_interconnect_request) :: ExAws.Request.JSON.response_t
  def describe_connections_on_interconnect(client, input) do
    request(client, "DescribeConnectionsOnInterconnect", format_input(input))
  end

  @doc """
  Same as `describe_connections_on_interconnect/2` but raise on error.
  """
  @spec describe_connections_on_interconnect!(client :: ExAws.DirectConnect.t, input :: describe_connections_on_interconnect_request) :: ExAws.Request.JSON.success_t | no_return
  def describe_connections_on_interconnect!(client, input) do
    case describe_connections_on_interconnect(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeInterconnects

  Returns a list of interconnects owned by the AWS account.

  If an interconnect ID is provided, it will only return this particular
  interconnect.
  """

  @spec describe_interconnects(client :: ExAws.DirectConnect.t, input :: describe_interconnects_request) :: ExAws.Request.JSON.response_t
  def describe_interconnects(client, input) do
    request(client, "DescribeInterconnects", format_input(input))
  end

  @doc """
  Same as `describe_interconnects/2` but raise on error.
  """
  @spec describe_interconnects!(client :: ExAws.DirectConnect.t, input :: describe_interconnects_request) :: ExAws.Request.JSON.success_t | no_return
  def describe_interconnects!(client, input) do
    case describe_interconnects(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeLocations

  Returns the list of AWS Direct Connect locations in the current AWS region.
  These are the locations that may be selected when calling CreateConnection
  or CreateInterconnect.
  """

  @spec describe_locations(client :: ExAws.DirectConnect.t) :: ExAws.Request.JSON.response_t
  def describe_locations(client) do
    request(client, "DescribeLocations", %{})
  end

  @doc """
  Same as `describe_locations/2` but raise on error.
  """
  @spec describe_locations!(client :: ExAws.DirectConnect.t) :: ExAws.Request.JSON.success_t | no_return
  def describe_locations!(client) do
    case describe_locations(client) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeVirtualGateways

  Returns a list of virtual private gateways owned by the AWS account.

  You can create one or more AWS Direct Connect private virtual interfaces
  linking to a virtual private gateway. A virtual private gateway can be
  managed via Amazon Virtual Private Cloud (VPC) console or the [EC2
  CreateVpnGateway](http://docs.aws.amazon.com/AWSEC2/latest/APIReference/ApiReference-query-CreateVpnGateway.html)
  action.
  """

  @spec describe_virtual_gateways(client :: ExAws.DirectConnect.t) :: ExAws.Request.JSON.response_t
  def describe_virtual_gateways(client) do
    request(client, "DescribeVirtualGateways", %{})
  end

  @doc """
  Same as `describe_virtual_gateways/2` but raise on error.
  """
  @spec describe_virtual_gateways!(client :: ExAws.DirectConnect.t) :: ExAws.Request.JSON.success_t | no_return
  def describe_virtual_gateways!(client) do
    case describe_virtual_gateways(client) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeVirtualInterfaces

  Displays all virtual interfaces for an AWS account. Virtual interfaces
  deleted fewer than 15 minutes before DescribeVirtualInterfaces is called
  are also returned. If a connection ID is included then only virtual
  interfaces associated with this connection will be returned. If a virtual
  interface ID is included then only a single virtual interface will be
  returned.

  A virtual interface (VLAN) transmits the traffic between the AWS Direct
  Connect location and the customer.

  If a connection ID is provided, only virtual interfaces provisioned on the
  specified connection will be returned. If a virtual interface ID is
  provided, only this particular virtual interface will be returned.
  """

  @spec describe_virtual_interfaces(client :: ExAws.DirectConnect.t, input :: describe_virtual_interfaces_request) :: ExAws.Request.JSON.response_t
  def describe_virtual_interfaces(client, input) do
    request(client, "DescribeVirtualInterfaces", format_input(input))
  end

  @doc """
  Same as `describe_virtual_interfaces/2` but raise on error.
  """
  @spec describe_virtual_interfaces!(client :: ExAws.DirectConnect.t, input :: describe_virtual_interfaces_request) :: ExAws.Request.JSON.success_t | no_return
  def describe_virtual_interfaces!(client, input) do
    case describe_virtual_interfaces(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  defp request(%{__struct__: client_module} = client, action, input) do
    apply(client_module, :request, [client, action, input])
  end
end
