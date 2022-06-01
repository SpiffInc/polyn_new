defmodule Mix.Tasks.Polyn.New do
  @moduledoc """
  Use `mix polyn.new` to generate a new code base for managing your NATS server with Polyn
  """
  @shortdoc "Generates a new Polyn codebase"

  use Mix.Task

  def run(_args) do
    Mix.Tasks.New.run(["polyn_admin"])
    Mix.Shell.IO.cmd("cd polyn_admin && git init")
    admin_path = Path.join(File.cwd!(), "polyn_admin")
    File.rm_rf!(Path.join(admin_path, "test"))
    File.rm_rf!(Path.join(admin_path, "lib"))
    File.mkdir_p!(Path.join(admin_path, "priv/polyn/schemas"))
    File.mkdir_p!(Path.join(admin_path, "priv/polyn/migrations"))
    File.write!(Path.join(admin_path, "priv/polyn/schemas/.gitkeep"), "")
    File.write!(Path.join(admin_path, "priv/polyn/migrations/.gitkeep"), "")

    File.copy!(
      Path.join(File.cwd!(), "priv/templates/README.md"),
      Path.join(admin_path, "README.md")
    )
  end
end
