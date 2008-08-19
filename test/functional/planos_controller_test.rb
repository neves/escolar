require 'test_helper'

class PlanosControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:planos)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_plano
    assert_difference('Plano.count') do
      post :create, :plano => { }
    end

    assert_redirected_to plano_path(assigns(:plano))
  end

  def test_should_show_plano
    get :show, :id => planos(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => planos(:one).id
    assert_response :success
  end

  def test_should_update_plano
    put :update, :id => planos(:one).id, :plano => { }
    assert_redirected_to plano_path(assigns(:plano))
  end

  def test_should_destroy_plano
    assert_difference('Plano.count', -1) do
      delete :destroy, :id => planos(:one).id
    end

    assert_redirected_to planos_path
  end
end
