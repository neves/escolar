require 'test_helper'

class PrevisoesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:previsoes)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_previsao
    assert_difference('Previsao.count') do
      post :create, :previsao => { }
    end

    assert_redirected_to previsao_path(assigns(:previsao))
  end

  def test_should_show_previsao
    get :show, :id => previsoes(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => previsoes(:one).id
    assert_response :success
  end

  def test_should_update_previsao
    put :update, :id => previsoes(:one).id, :previsao => { }
    assert_redirected_to previsao_path(assigns(:previsao))
  end

  def test_should_destroy_previsao
    assert_difference('Previsao.count', -1) do
      delete :destroy, :id => previsoes(:one).id
    end

    assert_redirected_to previsoes_path
  end
end
