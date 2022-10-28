defmodule PentoWeb.PageLive do
  use PentoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, query: "123", results: %{})}
  end

  def render(assigns) do
    ~H"""
    <%= @query %>
    """
  end
end
