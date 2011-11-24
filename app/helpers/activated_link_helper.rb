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

    html_options = html_options.clone
    url = options.is_a?(String) ? options : url_for(options)
    match = request.fullpath.match(/^#{Regexp.escape(url)}(?:\/(.*?))?(?:\?(.*))?$/)
    match_path = match.try :[], 1
    match_query = match.try :[], 2
    active = match.present?

    if html_options.delete(:exact)
      active &&= match_path.blank?
    end

    if paths = (html_options.delete(:only_paths).presence or html_options.delete(:only_path).presence)
      active &&= match_path.blank? || if paths.is_a? Array
        paths.include? match_path
      elsif paths.is_a? Regexp
        paths.match(match_path).present?
      else
        paths == match_path
      end
    end

    html_options[:class] ||= []
    html_options[:class].split! /\s+/ if html_options[:class].is_a? String
    html_options[:class] << "#{"in" unless active}active"

    link_to name, options, html_options
  end
end
