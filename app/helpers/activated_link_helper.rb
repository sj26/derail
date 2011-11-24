module ActivatedLinkHelper
  def activated_link_to *args, &block
    if block_given?
      name          = capture(&block)
      options       = args[0] || {}
      html_options  = args[1] || {}
    else
      name          = args[0]
      options       = args[1] || {}
      html_options  = args[2] || {}
    end

    options = options.clone
    html_options = html_options.clone

    url = url_for(options)
    active_link_options = html_options.delete(:active) || {}

    match = request.fullpath.match(/^#{Regexp.escape(url)}(?:\/(.*)$)?/)

    active = if html_options.delete(:exact)
      match.present? and (match[1].blank? or match[1] == "/")
    elsif paths = (html_options.delete(:only_paths).presence || html_options.delete(:only_path).presence)
      match.present? and (match[1].blank? or match[1] == "/") || if paths.is_a? Array
        paths.include? match[1]
      elsif paths.is_a? Regexp
        paths.match(match[1]).present?
      else
        paths == match[1]
      end
    else
      request.fullpath.match(/^#{Regexp.escape(url)}(\/|\?|$)/).present?
    end

    css_class = if active
      'active'
    else
      'inactive'
    end

    html_options[:class] ||= ''
    html_options[:class] += " #{css_class}" if !css_class.blank?
    html_options[:class].strip!
    html_options.delete(:class) if html_options[:class].blank?

    link_to(name, url, html_options)
  end
end