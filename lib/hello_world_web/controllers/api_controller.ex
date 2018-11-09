defmodule HelloWorldWeb.ApiController do
  use HelloWorldWeb, :controller

  def get_data(conn, _params) do
    json(conn, %{"Foo" => "Bar"})
  end
end
