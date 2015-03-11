class TodosController < ApplicationController
	before_action :set_list
	before_action :set_todo, except: [:create]

	def create
		@todo = @list.todo.create(todo_params)
		redirect_to @list
	end

    def	destroy
		if @todo.destroy
    		flash[:success] = t('todo_delete')
    	else
    		flash[:error] = t('todo_not_delete')
    	end
    	redirect_to @list
    end

    def done
    	@todo.update_attribute(:done, Time.now)
    	redirect_to @list, notice: t('task_done')
    end

    def edit	
    end

    def update
    	if @todo.update(todo_params)
    		flash[:success] = t('task_update')
    	else
    		flash[:error] = t('task_not_update')
    	end
    	redirect_to @list
    end

	private

		def set_list
			@list = List.find(params[:list_id])
		end

		def todo_params
			params[:todo].permit(:content)
		end

		def set_todo
			@todo = @list.todo.find(params[:id])
		end

end