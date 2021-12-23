defmodule Extraction do
  
  
  def extract_email(%{"email" => email}), do: {:email, email}
  def extract_email(_), do: {:error, "Email missing"}
  
  def extract_login(%{"login" => login}), do: {:login, login}
  def extract_login(_), do: {:error, "Login missing"}
  
  def extract_name(%{"name" => name}), do: {:name, name}
  def extract_name(_), do: {:error, "Name missing"}
  
  def extract_user(user) do
    with {:login, login} <- extract_login(user),
         {:name, name} <- extract_name(user),
         {:email, email} <- extract_email(user) do
      [name, login, email]
    end
  end
  
  def sweet() do
    :tastes_great
  end
    
  
end