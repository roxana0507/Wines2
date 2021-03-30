class WinesController < ApplicationController
  before_action :set_wine, only: %i[ show edit update destroy ]
  before_action :set_strains, only: %i[ new edit create ]
  before_action :set_wine_strains, only: %i[ new edit create ]
  before_action :authorize_admin,  except: %i[ index show  ]

  # GET /wines or /wines.json
  def index
    @wines = Wine.includes([wine_strains: [:strain]]).all 
  
  end

  # GET /wines/1 or /wines/1.json
  def show
  end

  # GET /wines/new
  def new
    @wine = Wine.new
    @strains = Strain.pluck(:name, :id)
    @wine.wine_strains.build
    @wine.wine_strains.build
    @wine.wine_strains.build
  end

  # GET /wines/1/edit
  def edit
    @strains = Strain.order(name: :asc)
    @wine.wine_strains.build
    @strains = Strain.pluck(:name, :id)
  end

  # POST /wines or /wines.json
  def create
    @wine = Wine.new(wine_params)

    respond_to do |format|
      if @wine.save
        format.html { redirect_to @wine, notice: 'Wine was successfully created.' }
        format.json { render :show, status: :created, location: @wine }
      else
        format.html { render :new }
        format.json { render json: @wine.errors, status: :unprocessable_entity }
      end
    end
  end



  # PATCH/PUT /wines/1 or /wines/1.json
  def update
    respond_to do |format|
      if @wine.update(wine_params)
        format.html { redirect_to @wine, notice: "Wine was successfully updated." }
        format.json { render :show, status: :ok, location: @wine }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @wine.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wines/1 or /wines/1.json
  def destroy
    @wine.destroy
    respond_to do |format|
      format.html { redirect_to wines_url, notice: "Wine was successfully destroyed." }
      format.json { head :no_content }
    end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wine
      @wine = Wine.find(params[:id])
    end

    def set_strains
      @strains = Strain.all
    end

    def authorize_admin
      #unless current_user&.admin?
      if user_signed_in?  
        unless current_user.admin?
          flash[:notice] = "Debes ser administrador para modificar vinos"
          redirect_to wines_path
        end
      else
         flash[:notice] = "Debes iniciar sesion para modificar vinos"
         redirect_to new_user_session_path
      end
    end

    def set_wine_strains
      @wine_strains = WineStrain.all
    end


    # Only allow a list of trusted parameters through.
    def wine_params
      params.require(:wine).permit(:name, wine_strains_attributes: [:id, :percentage, :wine_id, :strain_id])
    end
end