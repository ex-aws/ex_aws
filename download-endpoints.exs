Mix.install([
  :req
])

File.write!(
  "priv/endpoints.exs",
  inspect(
    Req.get!(
      "https://raw.githubusercontent.com/boto/botocore/refs/heads/develop/botocore/data/endpoints.json"
    ).body
    |> Jason.decode!(),
    limit: :infinity,
    printable_limit: :infinity
  )
)

System.cmd("mix", ["format"])
