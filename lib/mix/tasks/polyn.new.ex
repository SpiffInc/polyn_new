defmodule Mix.Tasks.Polyn.New do
  @moduledoc """
  Use `mix polyn.new` to generate a new code base for managing your NATS server with Polyn
  """
  @shortdoc "Generates a new Polyn codebase"

  use Mix.Task

  def run(args) do
    options = parse_args(args)
    generate_new_mix_project(options)
    initialize_git(options)
    remove_unused(options)
    create_priv_dirs(options)
    copy_readme(options)
    copy_tool_versions(options)
    add_mix_file(options)
  end

  defp parse_args(args) do
    {options, _positional} = OptionParser.parse!(args, strict: [path: :string])
    path = Keyword.get(options, :path, "polyn_admin") |> Path.relative_to_cwd()
    %{path: path}
  end

  defp generate_new_mix_project(options) do
    Mix.Tasks.New.run([options.path])
  end

  defp initialize_git(options) do
    Mix.Shell.IO.cmd("cd #{options.path} && git init")
  end

  defp remove_unused(options) do
    File.rm_rf!(Path.join(options.path, "test"))
    File.rm_rf!(Path.join(options.path, "lib"))
  end

  defp create_priv_dirs(options) do
    Mix.Generator.create_file("#{options.path}/priv/polyn/schemas/.gitkeep", "")
    Mix.Generator.create_file("#{options.path}/priv/polyn/migrations/.gitkeep", "")
  end

  defp copy_readme(options) do
    Mix.Generator.copy_file("priv/templates/README.md", "#{options.path}/README.md", force: true)
  end

  defp copy_tool_versions(options) do
    Mix.Generator.copy_file(".tool-versions", "#{options.path}/.tool-versions", force: true)
  end

  defp add_mix_file(options) do
    Mix.Generator.copy_file("priv/templates/mix.exs", "#{options.path}/mix.exs", force: true)
  end
end
