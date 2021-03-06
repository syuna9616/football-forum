class ImageUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  process :fix_rotate

   # アップロードした写真が回転してしまう問題に対応
   def fix_rotate
       manipulate! do |img|
           img = img.auto_orient
           img = yield(img) if block_given?
           img
       end
   end

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    # For Rails 3.1+ asset pipeline compatibility:
    # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
    'default.jpg'
  end 

  # Process files as they are uploaded:
  # process scale: [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #上限変更
    process :resize_to_limit => [300, 300]

  #JPGで保存
    process :convert => 'jpg'

  #サムネイルを生成
    version :thumb do
      process :resize_to_limit => [100, 100]
    end

  # jpg,jpeg,gif,pngのみ
    def extension_white_list
      %w(jpg jpeg gif png)
    end

  #ファイル名を変更し拡張子を同じにする
    def filename
      super.chomp(File.extname(super)) + '.jpg'
    end

  #日付で保存
    def filename
      if original_filename.present?
        time = Time.now
        name = time.strftime('%Y%m%d%H%M%S') + '.jpg'
        name.downcase
      end
    end
end
