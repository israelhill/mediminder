class DrugInfosController < ApplicationController
  # GET /drug_infos
  # GET /drug_infos.json
  def index
    @drug_infos = DrugInfo.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @drug_infos }
    end
  end

  # GET /drug_infos/1
  # GET /drug_infos/1.json
  def show
    @drug_info = DrugInfo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @drug_info }
    end
  end

  # GET /drug_infos/new
  # GET /drug_infos/new.json
  def new
    @drug_info = DrugInfo.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @drug_info }
    end
  end

  # GET /drug_infos/1/edit
  def edit
    @drug_info = DrugInfo.find(params[:id])
  end

  # POST /drug_infos
  # POST /drug_infos.json
  def create
    @drug_info = DrugInfo.new(params[:drug_info])

    respond_to do |format|
      if @drug_info.save
        format.html { redirect_to @drug_info, notice: 'Drug info was successfully created.' }
        format.json { render json: @drug_info, status: :created, location: @drug_info }
      else
        format.html { render action: "new" }
        format.json { render json: @drug_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /drug_infos/1
  # PUT /drug_infos/1.json
  def update
    @drug_info = DrugInfo.find(params[:id])

    respond_to do |format|
      if @drug_info.update_attributes(params[:drug_info])
        format.html { redirect_to @drug_info, notice: 'Drug info was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @drug_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /drug_infos/1
  # DELETE /drug_infos/1.json
  def destroy
    @drug_info = DrugInfo.find(params[:id])
    @drug_info.destroy

    respond_to do |format|
      format.html { redirect_to drug_infos_url }
      format.json { head :no_content }
    end
  end
end
