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



##################################################
##Word cloud based on the abstracts of my papers##
##################################################
#https://cran.r-project.org/web/packages/wordcloud2/vignettes/wordcloud.html#install-wordcloud2
#https://superstatisticienne.fr/wordcloud-avec-r/

# Load packages
library(readxl)
library(dplyr)
library(wordcloud2)
library(tm)
library(SnowballC)
library(RColorBrewer)
library(htmlwidgets)
library(webshot2)

# Load the data
info_abstracts <- read_excel("files/other/info_abstracts.xlsx")
head(info_abstracts)

# Extract abstracts and combine them into a single text
abstracts_text <- paste(info_abstracts$Abstract, collapse = " ")

# Create a text corpus
corpus <- Corpus(VectorSource(abstracts_text))

# Text cleaning (lower case, removal of stopwords, punctuation, etc.)
corpus <- corpus %>%
  tm_map(content_transformer(tolower)) %>%
  tm_map(removePunctuation) %>%
  tm_map(removeNumbers) %>%
  tm_map(removeWords, stopwords("en")) %>%
  tm_map(stripWhitespace)

# Create a term matrix
dtm <- TermDocumentMatrix(corpus)
matrix <- as.matrix(dtm)

# Count words and create a data frame
word_freq <- sort(rowSums(matrix), decreasing = TRUE)
data_wordcloud <- data.frame(word = names(word_freq), freq = word_freq)
data_wordcloud <- data_wordcloud %>% dplyr::filter(freq > 4)
unique(data_wordcloud$word)
data_wordcloud <- data_wordcloud %>% dplyr::filter(!word %in% c("found", "also", "high", "new", "will", "calvescens", "can", "however", "french", "importance", "infection", "mostly", "studies", "three", "well", "yet", "suggest", "therefore", "using", "antelope", "due", "one", "two", "whether", "within"))

continuous_colors <- colorRampPalette(brewer.pal(11, "Spectral"))(nrow(data_wordcloud)/2)

# Create the word clouds
wordcloud <- wordcloud2(data_wordcloud, size = 0.5, color = continuous_colors,
           backgroundColor = "white") 
wordcloud

# Add a title using `htmlwidgets` and HTML
wordcloud <- htmlwidgets::prependContent(
  wordcloud,
  htmltools::tags$h1("Word cloud based on the abstracts of my papers [Update October 2024]",
                     style = "text-align:center; color:black; font-family:sans-serif; font-size:14px; font-weight:bold;")
)
wordcloud


#continuous_colors <- colorRampPalette(c("#000000", "#5E4FA2", "#3288BD", "#66C2A5", "#ABDDA4", "#E6F598", "#FFFFBF", "#FEE08B", "#FDAE61", "#F46D43", "#D53E4F", "#9E0142"))(nrow(data_wordcloud)/2)
#wordcloud(
#  words = data_wordcloud$word,
#  freq = data_wordcloud$freq,
#  scale = c(3, 0.5), # Taille max et min des mots
#  colors = continuous_colors,
#  random.order = FALSE,
#  rot.per = 0.35, # Pourcentage de mots affichés verticalement
#  use.r.layout = FALSE
#)
