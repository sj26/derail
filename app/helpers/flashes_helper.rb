module FlashesHelper
  def flashes
    safe_join(flash.keys.map do |key|
      content_tag :aside, :class => ["flash", "flash-#{key.to_s.parameterize}"] do
        flash[key]
      end
    end)
  end
end
