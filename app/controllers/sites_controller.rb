class SitesController < ApplicationController

  # authenticate_user! ejecuta acción sólo si sesión existe
  before_filter :authenticate_user!,:except=> [:index,:show]

  #filtro para contador de visitas
  #after_filter :count_visit, :only => :show

  # GET /sites
  # GET /sites.json
  def index
    if params[:type_id].nil? or params[:type_id].empty?
      @sites = Site.all            # path: /types
      else
      @sites = Type.find(params[:type_id]).sites  # path: /types/id/sites
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sites }
    end
  end

  # GET /sites/1
  # GET /sites/1.json
  def show
    @site = Site.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @site }
    end
  end

  # GET /sites/new
  # GET /sites/new.json
  def new
    @site = current_user.sites.build #cambio Site por current_user.sites.build -- crea sitio vacio asociado a current_user

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @site }
    end
  end

  # GET /sites/1/edit
  def edit
    @site = current_user.sites.find(params[:id]) #cambio Site por current_user.sites -- busca solo en sitios asociados a current_user
  end

  # POST /sites
  # POST /sites.json
  def create
    @site = current_user.sites.build(params[:site]) #cambio Site.new por current_user.sites.build -- asigna solo si sitio asociado a current_user

    respond_to do |format|
      if @site.save
        format.html { redirect_to @site, notice: 'Site was successfully created.' }
        format.json { render json: @site, status: :created, location: @site }
      else
        format.html { render action: "new" }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sites/1
  # PUT /sites/1.json
  def update
    @site = current_user.sites.find(params[:id])  #cambio Site por current_user.sites.-- busca solo en sitios asociados a current_user

    respond_to do |format|
      if @site.update_attributes(params[:site])
        format.html { redirect_to @site, notice: 'Site was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sites/1
  # DELETE /sites/1.json
  def destroy
    @site = current_user.sites.find(params[:id])  #cambiar Site por current_user.sites -- busca solo en sitios asociados a current_user
    @site.destroy

    respond_to do |format|
      format.html { redirect_to sites_url }
      format.json { head :no_content }
    end
  end

  private

  #definicion de la funcion contadora de visitas
  #def count_visit
  #  @site.increment!(:visits)
  #end

end
