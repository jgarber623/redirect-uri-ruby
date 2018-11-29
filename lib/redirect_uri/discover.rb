module RedirectUri
  class Discover
    # Ultra-orthodox pattern matching allowed values in HTTP Link header `rel` parameter
    # https://tools.ietf.org/html/rfc8288#section-3.3
    REGEXP_REG_REL_TYPE_PATTERN = '[a-z\d][a-z\d\-\.]*'.freeze

    # Liberal pattern matching a string of text between angle brackets
    # https://tools.ietf.org/html/rfc5988#section-5.1
    REGEXP_TARGET_URI_PATTERN = /^<(.*)>;/.freeze

    # Ultra-orthodox pattern matching HTTP Link header `rel` parameter including an `redirect_uri` value
    # https://www.w3.org/TR/indieauth/#x4-discovery
    REGEXP_REDIRECT_URI_REL_PATTERN = /(?:;|\s)rel="?(?:#{REGEXP_REG_REL_TYPE_PATTERN}+\s)?redirect_uri(?:\s#{REGEXP_REG_REL_TYPE_PATTERN})?"?/.freeze

    def initialize(response)
      raise ArgumentError, "response must be an HTTP::Response (given #{response.class.name})" unless response.is_a?(HTTP::Response)

      @response = response
    end

    def endpoints
      return unless endpoints_from_http_request.any?

      @endpoints ||= endpoints_from_http_request.map { |endpoint| Absolutely.to_absolute_uri(base: @response.uri.to_s, relative: endpoint) }.uniq.sort
    rescue Absolutely::InvalidURIError => error
      raise InvalidURIError, error
    end

    private

    def endpoints_from_body
      return unless @response.mime_type == 'text/html'

      doc = Nokogiri::HTML(@response.body.to_s)

      link_elements = doc.css('link[rel~="redirect_uri"][href]')

      link_elements.map { |link_element| link_element['href'] }
    end

    def endpoints_from_headers
      link_headers = @response.headers.get('link')

      return unless link_headers

      # Split Link headers with multiple values, flatten the resulting array, and strip whitespace
      link_headers = link_headers.map { |header| header.split(',') }.flatten.map(&:strip)

      redirect_uri_headers = link_headers.find_all { |header| header.match?(REGEXP_REDIRECT_URI_REL_PATTERN) }

      return unless redirect_uri_headers.any?

      redirect_uri_headers.map do |header|
        endpoint_match_data = header.match(REGEXP_TARGET_URI_PATTERN)

        endpoint_match_data[1] if endpoint_match_data
      end
    end

    def endpoints_from_http_request
      @endpoints_from_http_request ||= [endpoints_from_headers, endpoints_from_body].flatten.compact
    end
  end
end
