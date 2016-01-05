Code.require_file("default_helper.exs", __DIR__)
Code.require_file("alternate_helper.exs", __DIR__)

Application.ensure_all_started(:httpoison)
Application.ensure_all_started(:jsx)

ExUnit.start()
