module Admin
  class ProjectsController < BaseController
    ALLOWED_EXTENSIONS = %w[.jpg .jpeg .png .gif .webp].freeze
    UPLOAD_DIR = Rails.root.join("public/uploads/projects")

    def new
      @project = Project.new
    end

    def create
      @project = Project.new(project_params)
      @project.status = params[:commit] == "publish" ? "published" : "draft"
      handle_thumbnail
      if @project.save
        redirect_to admin_root_path, notice: "Project created"
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
      @project = Project.find(params[:id])
    end

    def update
      @project = Project.find(params[:id])
      @project.assign_attributes(project_params)
      @project.status = params[:commit] == "publish" ? "published" : "draft"
      handle_thumbnail
      if @project.save
        redirect_to admin_root_path, notice: "Project updated"
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @project = Project.find(params[:id])
      delete_thumbnail(@project.thumbnail)
      @project.destroy
      redirect_to admin_root_path, notice: "Project deleted"
    end

    private

    def project_params
      permitted = params.require(:project).permit(:title, :body, :project_date_month, :project_date_year)
      month = permitted.delete(:project_date_month)
      year = permitted.delete(:project_date_year)
      if year.present? && month.present?
        permitted[:project_date] = Date.new(year.to_i, month.to_i, 1)
      else
        permitted[:project_date] = nil
      end
      permitted
    end

    def handle_thumbnail
      file = params.dig(:project, :thumbnail)
      return unless file.is_a?(ActionDispatch::Http::UploadedFile)

      ext = File.extname(file.original_filename).downcase
      unless ALLOWED_EXTENSIONS.include?(ext)
        @project.errors.add(:thumbnail, "must be a JPG, PNG, GIF, or WebP image")
        return
      end

      delete_thumbnail(@project.thumbnail_was) if @project.thumbnail_was.present?

      filename = "#{SecureRandom.hex(8)}#{ext}"
      FileUtils.mkdir_p(UPLOAD_DIR)
      filepath = UPLOAD_DIR.join(filename)
      File.open(filepath, "wb") { |f| f.write(file.read) }

      image = MiniMagick::Image.open(filepath)
      image.resize("800x800>")
      image.write(filepath)

      @project.thumbnail = filename
    end

    def delete_thumbnail(filename)
      return if filename.blank?
      path = UPLOAD_DIR.join(filename)
      File.delete(path) if File.exist?(path)
    end
  end
end
