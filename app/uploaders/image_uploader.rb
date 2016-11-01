# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  include CarrierWave::RMagick
  include CarrierWave::MiniMagick
  include Magick
  include MiniMagick
  # Choose what kind of storage toxs use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  process :scale => [200, 300]

  def scale(width, height)
    # do something

  end

  # Create different versions of your uploaded files:
  version :thumb do
      process :resize_to_limit => [200, 200]
     process :add_text
  end


  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def add_text
    manipulate! do |image|
      image.combine_options do |c|
        c.gravity 'south_east'
        c.pointsize '22'
        c.draw "text 0,0 '#{model.name}'"
        c.fill 'white'
      end
      image
    end
  end


#   def poster
#   manipulate! format: "jpg" do |source|
#   txt = Magick::Draw.new
#   txt.pointsize = 12
#   txt.gravity = Magick::SouthGravity
#   txt.stroke = "#000000"
#   title = "FSJIDFOSDF"
#   source = source.resize_to_fill(400, 400).border(10, 10, "black")
#   # source.annotate(txt, 0, 0, 0, 40, title)

# end
# txt.write('final.jpg')
# end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end


end
