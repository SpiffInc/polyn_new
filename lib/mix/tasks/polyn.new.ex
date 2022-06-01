defmodule Mix.Tasks.Polyn.New do
  @moduledoc """
  Use `mix polyn.new` to generate a new code base for managing your NATS server with Polyn
  """
  @shortdoc "Generates a new Polyn codebase"

  use Mix.Task

  def run(_args) do
    generate_new_mix_project()
    initialize_git()
    remove_unused()
    create_priv_dirs()
    copy_readme()
    copy_tool_versions()
  end

  defp generate_new_mix_project do
    Mix.Tasks.New.run(["polyn_admin"])
  end

  defp initialize_git do
    Mix.Shell.IO.cmd("cd polyn_admin && git init")
  end

  defp remove_unused do
    File.rm_rf!(Path.join(admin_path(), "test"))
    File.rm_rf!(Path.join(admin_path(), "lib"))
  end

  defp admin_path do
    Path.join(File.cwd!(), "polyn_admin")
  end

  defp create_priv_dirs do
    File.mkdir_p!(Path.join(admin_path(), "priv/polyn/schemas"))
    File.mkdir_p!(Path.join(admin_path(), "priv/polyn/migrations"))
    File.write!(Path.join(admin_path(), "priv/polyn/schemas/.gitkeep"), "")
    File.write!(Path.join(admin_path(), "priv/polyn/migrations/.gitkeep"), "")
  end

  defp copy_readme do
    File.copy!(
      Path.join(File.cwd!(), "priv/templates/README.md"),
      Path.join(admin_path(), "README.md")
    )
  end

  defp copy_tool_versions do
    File.copy!(
      Path.join(File.cwd!(), ".tool-versions"),
      Path.join(admin_path(), ".tool-versions")
    )
  end
end
