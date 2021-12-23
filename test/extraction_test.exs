defmodule Extraction.Tests do
  use ExUnit.Case, async: true

  
  doctest Extraction
  
  test "Extract Email from valid map" do
    valid_map = %{
      "email" => "jim.doe@erlef.org",
      "login" => "rlef",
      "name" => "rafael"
    }
    assert Extraction.extract_email(valid_map) == {:email, "jim.doe@erlef.org"}
  end


  test "Extract Email default clause" do
    no_mail_map = %{
      "login" => "",
      "name" => "rafael"
    }
    assert Extraction.extract_email(no_mail_map) == {:error, "Email missing"}    
  end
  
  test "Extract login from valid map" do
    valid_map = %{
      "email" => "jim.doe@erlef.org",
      "login" => "rlef",
      "name" => "rafael"
    }
    assert Extraction.extract_login(valid_map) == {:login, "rlef"}
  end
  
  test "Extract login default clause" do
    no_login_map = %{
      "name" => "rafael"
    }
    assert Extraction.extract_login(no_login_map) == {:error, "Login missing"}
  end
  
  test "Extract Name from valid map" do
    valid_map = %{
      "email" => "jim.doe@erlef.org",
      "login" => "rlef",
      "name" => "rafael"
    }
    assert Extraction.extract_name(valid_map) == {:name, "rafael"}    
  end
  
  test "Extract name default clause" do
    no_name_map = %{
      "email" => "jim.doe@erlef.org",
      "login" => "rlef",
    }
    assert Extraction.extract_name(no_name_map) == {:error, "Name missing"}
  end
  
  test "Extract user from valid map" do
    valid_map = %{
      "email" => "jim.doe@erlef.org",
      "login" => "rlef",
      "name" => "rafael"
    }
    assert Extraction.extract_user(valid_map) == ["rafael", "rlef", "jim.doe@erlef.org"]
  end
  

#  Indeed it returns "Name Missing"
  test "Extract user from invalid_map" do
    invalid_map = %{
      "email" => "jim.doe@erlef.org",
      "login" => "rlef",
    }
    assert Extraction.extract_user(invalid_map) == {:error, "Name missing"}
  end
  
  test "Extract user for empty map" do
    empty_map = %{}
    assert Extraction.extract_user(empty_map) == {:error, "Login missing"} ## this should fail first
  end
  
  test "Sweet tastes good" do
    assert Extraction.sweet() == :tastes_great
  end
  

  
  ## Study recap:
  ## What we did: 
  ## 1) wrote tests for extract_email, extract_name and extract_login DEFAULT cases
  ## 2) wrote the functions for default cases
  ## 3) wrote tests for practical cases
  ## 4) wrote the functions to make the tests green
  ## 5) Wrote test for extract_user with valid map
  ## 6) implemented extract_user
  ## 7) wrote test for invalid input
  ## 8) test succeeded.
  
  
end