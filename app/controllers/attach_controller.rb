require 'action_controller/railtie'

class AttachController < ActionController::Base
  def create
    klass = params[:model].classify.constantize.find(params[:id])
    file = klass.send(params[:relation].pluralize).create(params[:relation].singularize => params[:file])
    klass.save
    
    render :partial => "/#{file.class::TYPE}", :locals => {:attachment => file}
  end
  
  def destroy
    image = params[:model].classify.constantize.find(params[:id]).send(params[:relation].pluralize).find(params[:relation_id])
    image.destroy
    render nothing: true
  end
end
