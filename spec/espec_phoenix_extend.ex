defmodule ESpec.Phoenix.Extend do
  def model do
    quote do
      alias Scrawley.Repo
    end
  end

  def controller do
    quote do
      alias Scrawley
      import Scrawley.Router.Helpers

      @endpoint Scrawley.Endpoint
    end
  end

  def view do
    quote do
      import Scrawley.Router.Helpers
    end
  end

  def channel do
    quote do
      alias Scrawley.Repo

      @endpoint Scrawley.Endpoint
    end
  end

  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
