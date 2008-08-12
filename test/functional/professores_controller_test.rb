require 'test_helper'

class ProfessoresControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:professores)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_professor
    assert_difference('Professor.count') do
      post :create, :professor => { }
    end

    assert_redirected_to professor_path(assigns(:professor))
  end

  def test_should_show_professor
    get :show, :id => professores(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => professores(:one).id
    assert_response :success
  end

  def test_should_update_professor
    put :update, :id => professores(:one).id, :professor => { }
    assert_redirected_to professor_path(assigns(:professor))
  end

  def test_should_destroy_professor
    assert_difference('Professor.count', -1) do
      delete :destroy, :id => professores(:one).id
    end

    assert_redirected_to professores_path
  end
end
