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
    add_mix_file()
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
    Mix.Generator.create_file("polyn_admin/priv/polyn/schemas/.gitkeep", "")
    Mix.Generator.create_file("polyn_admin/priv/polyn/migrations/.gitkeep", "")
  end

  defp copy_readme do
    Mix.Generator.copy_file("priv/templates/README.md", "polyn_admin/README.md", force: true)
  end

  defp copy_tool_versions do
    Mix.Generator.copy_file(".tool-versions", "polyn_admin/.tool-versions", force: true)
  end

  defp add_mix_file do
    Mix.Generator.copy_file("priv/templates/mix.exs", "polyn_admin/mix.exs", force: true)
  end
end
