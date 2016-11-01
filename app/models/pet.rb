class Pet < ActiveRecord::Base
	mount_uploader :image, ImageUploader

	validates_processing_of :image
  validate :image_size_validation

  before_save :edit_image

  def edit_image
    puts self.name
    puts self
    # Manipulator.add_custom_text(image, self.name)
  end


private
  def image_size_validation
    errors[:image] << "should be less than 500KB" if image.size > 0.5.megabytes
  end



end
