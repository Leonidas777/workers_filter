class SearchWorkersService

  def self.search_by(workers, query={})
    search_service = SearchWorkersService.new

    parameters = search_service.sanitize_params(query)

    workers.reject do |worker|
      reject_status = false

      parameters.each do |name, range|
        unless worker.send(name).between?(range[:from], range[:to])
          reject_status = true
          break
        end
      end

      reject_status
    end
  end

  def sanitize_params(query)
    query.select do |key, value|
      return false unless key.to_s.match(/^age|salary|height|weight$/)

      has_range_keys?(value)
    end
  end

  private

  def has_range_keys?(hash)
    [:from, :to].all? { |key| hash.key? key }
  end
end
