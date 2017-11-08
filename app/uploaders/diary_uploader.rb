class DiaryUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  process resize_to_fill: [250, 250]

  storage :file

  def default_url
    "https://dummyimage.com/250x250"
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end
end
