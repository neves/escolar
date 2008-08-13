require 'test_helper'

class AlunosControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:alunos)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_aluno
    assert_difference('Aluno.count') do
      post :create, :aluno => { }
    end

    assert_redirected_to aluno_path(assigns(:aluno))
  end

  def test_should_show_aluno
    get :show, :id => alunos(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => alunos(:one).id
    assert_response :success
  end

  def test_should_update_aluno
    put :update, :id => alunos(:one).id, :aluno => { }
    assert_redirected_to aluno_path(assigns(:aluno))
  end

  def test_should_destroy_aluno
    assert_difference('Aluno.count', -1) do
      delete :destroy, :id => alunos(:one).id
    end

    assert_redirected_to alunos_path
  end
end
