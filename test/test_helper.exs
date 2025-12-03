Code.require_file("default_helper.exs", __DIR__)
Code.require_file("alternate_helper.exs", __DIR__)
Code.require_file("telemetry_helper.exs", __DIR__)

Application.ensure_all_started(:hackney)
Application.ensure_all_started(:jsx)
Application.ensure_all_started(:bypass)

Mox.defmock(ExAws.Request.HttpMock, for: ExAws.Request.HttpClient)
Mox.defmock(ExAws.Credentials.InitMock, for: ExAws.CredentialsIni.Provider)

ExUnit.start()
