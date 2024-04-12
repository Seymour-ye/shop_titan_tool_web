class BlueprintsController < ApplicationController
  before_action :set_blueprint, only: %i[ show edit update destroy ]
  before_action :set_filters,   only: %i[ index show filter_update]

  # GET /blueprints or /blueprints.json
  def index
    @blueprints = Blueprint.all 
  end

  # GET /blueprints/1 or /blueprints/1.json
  def show
  end

  # GET /blueprints/new
  def new
    @blueprint = Blueprint.new
  end

  # GET /blueprints/1/edit
  def edit
  end

  # POST /blueprints or /blueprints.json
  def create
    @blueprint = Blueprint.new(blueprint_params)

    respond_to do |format|
      if @blueprint.save
        format.html { redirect_to blueprint_url(@blueprint), notice: "Blueprint was successfully created." }
        format.json { render :show, status: :created, location: @blueprint }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @blueprint.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blueprints/1 or /blueprints/1.json
  def update
    respond_to do |format|
      if @blueprint.update(blueprint_params)
        format.html { redirect_to blueprint_url(@blueprint), notice: "Blueprint was successfully updated." }
        format.json { render :show, status: :ok, location: @blueprint }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @blueprint.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blueprints/1 or /blueprints/1.json
  def destroy
    @blueprint.destroy

    respond_to do |format|
      format.html { redirect_to blueprints_url, notice: "Blueprint was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def filter_update
    filter = {}
    filter_not = {}

    if params["valid_resource"]
      params["valid_resource"].each do |resource|
        filter_not[resource.to_sym] = nil 
      end
    end

    if params["invalid_resource"]
      params["invalid_resource"].each do |resource|
        filter[resource.to_sym] = nil
      end
    end
    filter[:tier] = params["tier"]
    filter[:category] = params["category"]

    @blueprints = Blueprint.where(filter)

    if !filter_not.empty?
      filter_not.each do |key, val|
        @blueprints = @blueprints.where.not(key => val)
      end
    end

    respond_to do |format|
      format.html { redirect_to blueprints_url}
      format.turbo_stream
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blueprint
      @blueprint = Blueprint.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def blueprint_params
      params.fetch(:blueprint, {})
    end

    def set_filters
      @tiers = Blueprint.select(:tier).distinct.pluck(:tier).sort!
      @weapons = ['sword', 'axe', 'dagger', 'mace', 'spear', 'bow', 'wand', 'staff', 'gun', 'crossbow', 'instrument']
      @accessories = ['herbal_medicine', 'potion', 'spell', 'shield', 'ring', 'amulet', 'cloak', 'familiar', 'aurasong','meal', 'dessert']
      @armors = ['heavy_armor', 'light_armor', 'clothes','helmet','rogue_hat', 'magician_hat', 'gauntlets', 'gloves', 'heavy_footwear','light_footwear']
      @other_categories = ['runestone', 'moonstone', 'element', 'spirit']
      @resources = ['iron', 'wood', 'leather', 'herbs', 'steel', 'ironwood', 'fabric', 'oil', 'jewels', 'ether', 'essence']
    end
end
