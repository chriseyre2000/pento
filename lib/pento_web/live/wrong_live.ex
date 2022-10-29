defmodule PentoWeb.WrongLive do
  use PentoWeb, :live_view

  def mount(_params, session, socket) do
    {
      :ok,
      assign(socket,
        score: 0,
        message: "Guess a number.",
        answer: Enum.random(1..10),
        user: Pento.Accounts.get_user_by_session_token(session["user_token"]),
        session_id: session["live_socket_id"]
      )
    }
  end

  def render(assigns) do
    ~L"""
    <h1>Your score: <%= @score %></h1>
    <h2>
      <%= @message %>
    </h2>
    <h2>
      <%= for n <- 1..10 do %>
        <a href="#" phx-click="guess" phx-value-number="<%= n %>"><%= n %>  </a>
      <% end %>
    </h2>
    <pre>
      <%= @user.email %>
      <%= @session_id %>
    </pre>
    """
  end

  def handle_event("guess", %{"number" => guess} = data, socket) do
    IO.inspect(socket.assigns, label: :assigns)

    # message = "Your guess: #{guess}. Wrong. Guess again. "

    {score, message, answer} =
      if guess == "#{socket.assigns.answer}" do
        {socket.assigns.score + 1, "Well done. Try another.", Enum.random(1..10)}
      else
        {socket.assigns.score - 1, "Your guess: #{guess}. Wrong. Guess again. ",
         socket.assigns.answer}
      end

    {
      :noreply,
      assign(socket,
        message: message,
        score: score,
        answer: answer
      )
    }
  end
end
