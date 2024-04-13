class MetadataJob < ApplicationJob
  def perform(id)
    link = Link.find(id)
    link.update Metadata.retrieve_from(link.url).attributes

    # Broadcast any changes as soon as they come
    link.broadcast_replace_to(link)
  end
end