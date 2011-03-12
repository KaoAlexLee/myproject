class EventsController < ApplicationController
	
	# 在 show, edit, update, destory 的 Action 中都有相同的程式碼。
	# 相同程式碼是 @event = Event.find( params[:id] )
	# 簡化程式碼就是加上以下這段，定義一個共同執行的 Action
	# 並在此檔案最後面增加 protected 之下的程式碼，並將相同的程式碼放到 def find_event 裡，
	before_filter :find_event,:only => [:show, :edit, :update, :destroy ]

	def index
		
		#
		
		#@events = Event.all                        # 將全部的資料取出 
		@events = Event.page( params[:page]).per(3) # 將資料分頁取出，每頁 3 筆資料。
		
		respond_to do |format|
			format.html # index.html.erb
			format.json { render :json => @events.to_json }
			format.xml { render :xml => @events.to_xml}
			format.atom { @feed_title = "My event list"}   # 相對應 index.atom.builder
		end
	end
   
	def show
      
		respond_to do |format|
			format.html # index.html.erb
			format.json { render :json => @events.to_json }
			format.xml { render :xml => @events.to_xml}
			format.atom{ @feed_title = "My event list"}   # 相對應 index.atom.builder
		end
	end
   
	# display a event form
	def new
		
		@event = Event.new
	end
   
	def create
		 
		@event = Event.new( params[:event])
		if	@event.save
	
			flash[:notice] = "新增成功"
			redirect_to :action => :index
		else
			
			render :action => :new               #use new template, not execute
		end
	end
   
   #display a event form
   def edit
	
		@event = Event.find( params[:id] )
   end
   
	def update
		
		if @event.update_attributes( params[:event] )
	
			flash[:notice] = "更新成功"
			redirect_to :action => :index
		else
		
			render :action => :edit
		end
	end
   
	def destroy
   
		@event.destroy
		
		flash[:alert] ="刪除成功"
		redirect_to :action => :index
	end
   
	protected
	
	def find_event
	
		@event = Event.find( params[:id] )
	end
end
