#########################
##CO-AUTHORSHIP NETWORK##
#########################

# Load packages
library(readxl)
library(igraph)
library(ggraph)
library(tidyverse)
library(RColorBrewer)

# Load the data
coauthors <- read_excel("files/other/info_coauthors.xlsx")
head(coauthors)

# Generate the edgelist of co-authors correctly
edgelist <- coauthors %>%
  group_by(PaperID) %>%
  summarise(AuthorPairs = list(as.data.frame(t(combn(Author, 2))))) %>%
  unnest(AuthorPairs) %>%
  rename(Author1 = V1, Author2 = V2) %>%
  distinct() %>%
  select(-PaperID) 

# View the edgelist
head(edgelist)

# Create a graph from the filtered edgelist
g <- graph_from_data_frame(d = edgelist, directed = FALSE)
community <- cluster_louvain(g)

# Assign colors based on the community membership
V(g)$group <- membership(community)  # Add a group ID to each node
colors <- brewer.pal(max(V(g)$group), 'Spectral')  # Generate a color palette based on the number of groups
V(g)$colors <- colors[V(g)$group]

# Highlight Camille Leclerc in a different color (e.g., red)
my_name <- "Camille Leclerc"
V(g)$colors[V(g)$name == my_name] <- "#f7f7f7"
V(g)$label.colors <- "black"

# Set node sizes based on degree (number of connections)
V(g)$size <- degree(g) * 3  # Adjust size scaling if needed
V(g)$label.cex <- ifelse(V(g)$name == my_name, 4, 2)

# Use ggraph to create the network visualization
ggraph(g, layout = 'fr') +
  geom_edge_link(aes(alpha = 0.5), color = "gray70", show.legend = FALSE) +
  geom_node_point(aes(size = size, fill = colors), shape = 21, color = "black", show.legend = FALSE) +  # Set border to black
  geom_node_text(aes(label = name), repel = TRUE, size = V(g)$label.cex, show.legend = FALSE) +
  scale_fill_identity() +  # Use the fill colors directly
  theme_void() +
  ggtitle("Snapshot view of my collaborations [Update October 2024]") +
  theme(plot.title = element_text(face = "bold", size = 10, hjust = 0.5))

