require 'test_helper'

class PlanoContasControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:plano_contas)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_plano_conta
    assert_difference('PlanoConta.count') do
      post :create, :plano_conta => { }
    end

    assert_redirected_to plano_conta_path(assigns(:plano_conta))
  end

  def test_should_show_plano_conta
    get :show, :id => plano_contas(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => plano_contas(:one).id
    assert_response :success
  end

  def test_should_update_plano_conta
    put :update, :id => plano_contas(:one).id, :plano_conta => { }
    assert_redirected_to plano_conta_path(assigns(:plano_conta))
  end

  def test_should_destroy_plano_conta
    assert_difference('PlanoConta.count', -1) do
      delete :destroy, :id => plano_contas(:one).id
    end

    assert_redirected_to plano_contas_path
  end
end
