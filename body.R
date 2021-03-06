dbBody = dashboardBody(
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
  ),
  ## tags$head(tags$style(HTML(".small-box {height: 95px}"))),
  fluidRow(
    column(
      width = 12, offset = 0,
      tabItems(
################################################################################
        ## Stats page body
################################################################################
        tabItem(
          tabName = 'stats',
          fluidRow(
            ## title
            column(width = 10, offset = 1, align = 'center', h1(tags$i('Statistics and Rankings')), tags$br()),
            ## Navigation guide
            column(width = 10, offset = 1, 
                   box(title = 'User Guide', status = 'warning', solidHeader = T, width = NULL,
                       collapsible = T, collapsed = T, includeMarkdown('./Overview.md'))),
            ## filtering criteria
            column(
              width = 3,
              box(title = 'Year released', status = 'info', solidHeader = T, width = NULL,
                  sliderInput(inputId = 'year', label = NULL, min = 1900, max = 2017,
                              value = c(1970, 2017))
                  ),
              ## need review count data for this filer
              ## box(title = 'Minimum reviews', status = 'info', solidHeader = T, width = NULL,
              ##     sliderInput(inputId = 'minReview', label = NULL, min = 0, max = 300,
              ##                 value = c(0, 300))
              ##     ),
              box(title = 'Minimum number of movies - director', status = 'info', solidHeader = T, width = NULL,
                  sliderInput(inputId = 'min_movies_dir', label = NULL, min = 1, max = 15, value = 8)
                  ),
              box(title = 'Minimum number of movies - actor', status = 'info', solidHeader = T, width = NULL,
                  sliderInput(inputId = 'min_movies_act', label = NULL, min = 1, max = 20, value = 10)
                  ),
              box(title = 'Minimum number of movies - duo', status = 'info', solidHeader = T, width = NULL,
                  sliderInput(inputId = 'min_movies_duo', label = NULL, min = 1, max = 8, value = 5)
                  ),
              ## need to scrape more actors from IMDb for this filter, the OMDb API only have the top 4 actors
              ## box(title = 'First n actors in credits', status = 'info', solidHeader = T, width = NULL,
              ##     sliderInput(inputId = 'first_n_actors', label = NULL, min = 1, max = 20, value = 10)
              ##     ),
              box(title = 'Genres', status = 'info', solidHeader = T, width = NULL,
                  checkboxGroupInput(inputId = 'genre', label = NULL,
                                     choices = genres, selected = genres),
                  actionButton(inputId = 'checkAll', label = 'Check all'),
                  actionButton(inputId = 'uncheckAll', label = 'Clear all')
                  )
            ),
            ## results area
            column(
              width = 9, align = 'center',
              tabBox(
                title = 'Visualizations and Rankings', width = NULL,
################################################################################
                ## plotting area
################################################################################
                tabPanel(
                  title = 'Visualizations',
                  fluidRow(
                    column(
                      width = 12, offset = 0, align = 'center',
                      ## yearly trend
                      box(
                        title = 'Yearly Average Rating', status = 'success', width = NULL,
                        solidHeader = TRUE, collapsible = TRUE,
                        tabBox(
                          title = NULL, width = NULL,
                          tabPanel(title = 'IMDb Rating', plotlyOutput(outputId = 'trend_imdb')),
                          tabPanel(title = 'Metascore', plotlyOutput(outputId = 'trend_meta')),
                          tabPanel(title = 'Tomatometer', plotlyOutput(outputId = 'trend_rt'))
                        )
                      ),
                      ## boxplot by genre
                      box(
                        title = 'Distribution of Ratings by Genre', status = 'success', width = NULL,
                        solidHeader = TRUE, collapsible = TRUE,
                        tabBox(
                          title = NULL, width = NULL,
                          tabPanel(title = 'IMDb Rating', plotlyOutput(outputId = 'box_imdb', height = 500)),
                          tabPanel(title = 'Metascore', plotlyOutput(outputId = 'box_meta', height = 500)),
                          tabPanel(title = 'Tomatometer', plotlyOutput(outputId = 'box_rt', height = 500))
                        )
                      ),
                      ## scatter plot of box office over time/rating
                      box(
                        title = 'Box Office', status = 'success', width = NULL,
                        solidHeader = TRUE, collapsible = TRUE, 
                        tabBox(
                          title = NULL, width = NULL,
                          tabPanel(title = 'By Year', plotlyOutput(outputId = 'bo_year', height = 600)),
                          tabPanel(title = 'IMDb Rating', plotlyOutput(outputId = 'bo_imdb', height = 600)),
                          tabPanel(title = 'Metascore', plotlyOutput(outputId = 'bo_meta', height = 600)),
                          tabPanel(title = 'Tomatometer', plotlyOutput(outputId = 'bo_rt', height = 600))
                        )
                      )
                    )
                  )
                ),
################################################################################
                ## rankings
################################################################################
                tabPanel(
                  title = 'Director/Actor Rankings',
                  fluidRow(
                    column(
                      width = 12, offset = 0, align = 'center',
                      box(
                        title = 'Top Directors by Average Rating', status = 'success', width = NULL,
                        solidHeader = TRUE, collapsible = TRUE,
                        tabBox(
                          title = NULL, width = NULL,
                          tabPanel(title = 'IMDb Rating', dataTableOutput(outputId = 'top_dir_imdb')),
                          tabPanel(title = 'Metascore', dataTableOutput(outputId = 'top_dir_meta')),
                          tabPanel(title = 'Tomatometer', dataTableOutput(outputId = 'top_dir_rt'))
                        )
                      ),
                      box(
                        title = 'Top Actors by Average Rating', status = 'success', width = NULL,
                        solidHeader = TRUE, collapsible = TRUE,
                        tabBox(
                          title = NULL, width = NULL,
                          tabPanel(title = 'IMDb Rating', dataTableOutput(outputId = 'top_act_imdb')),
                          tabPanel(title = 'Metascore', dataTableOutput(outputId = 'top_act_meta')),
                          tabPanel(title = 'Tomatometer', dataTableOutput(outputId = 'top_act_rt'))
                        )
                      ),
                      box(
                        title = 'Top Director-Actor Duos by Average Rating', status = 'success', width = NULL,
                        solidHeader = TRUE, collapsible = TRUE,
                        tabBox(
                          title = NULL, width = NULL,
                          tabPanel(title = 'IMDb Rating', dataTableOutput(outputId = 'top_duo_imdb')),
                          tabPanel(title = 'Metascore', dataTableOutput(outputId = 'top_duo_meta')),
                          tabPanel(title = 'Tomatometer', dataTableOutput(outputId = 'top_duo_rt'))
                        )
                      )
                    )
                  )
                )
              )
            )
          )
        ),
################################################################################
        ## Director insights page
################################################################################
        tabItem(
          tabName = 'director',
          fluidRow(
            column(width = 10, offset = 1, align = 'center', h1(tags$i('Director Insights')), tags$br()),
            box(
              title = 'General Information', status = 'danger', width = 6, height = 390, 
              collapsible = FALSE, solidHeader = TRUE,
              uiOutput(outputId = 'dir_gen_info')
            ),
            box(
              title = 'Career Highlights', status = 'danger', width = 6, height = 390,
              collapsible = FALSE, solidHeader = TRUE,
              uiOutput(outputId = 'dir_carir_hlt')
            )
          ),
          fluidRow(
            box(
              title = 'Statistics', status = 'success', width = 6,
              collapsible = TRUE, solidHeader = TRUE, 
              tabBox(
                title = NULL, width = NULL,
                tabPanel(
                  title = 'Movies', h3('Summary Statistics'), hr(), dataTableOutput(outputId = 'dir_sumry'), br(),
                  h3('All Movies'), hr(), dataTableOutput(outputId = 'dir_movies')
                ),
                tabPanel(
                  title = 'Collaborations',
                  box(width = NULL, uiOutput(outputId = 'dir_collab'), hr(), formattableOutput(outputId = 'dir_ft_most_collab'))
                )
              )
            ),
            box(
              title = 'Visualizations', status = 'success', width = 6,
              collapsible = TRUE, solidHeader = TRUE, collapsed = FALSE,
              tabBox(
                title = NULL, width = NULL,
                tabPanel(
                  title = 'Ratings', 
                  radioButtons('dir_radio', label = 'Select rating source: ', choices = c('IMDb Rating', 'Metascore', 'Tomatometer'),
                               selected = 'IMDb Rating', inline = T),
                  box(width = NULL, h3('Movie Ratings'), hr(), plotlyOutput('dir_movies_bar')), 
                  box(width = NULL, h3('Movie Timeline'), hr(), plotlyOutput('dir_timeline'))
                ),
                tabPanel(
                  title = 'Genres',
                  box(width = NULL, h3('Genres Played in', hr(), plotlyOutput('dir_genres_loli')))
                )
              )
            )
          )
        ),
################################################################################
        ## Actor insights page
################################################################################
        tabItem(
          tabName = 'actor',
          fluidRow(
            column(width = 10, offset = 1, align = 'center', h1(tags$i('Actor Insights')), tags$br()),
            box(
              title = 'General Information', status = 'danger', width = 6, height = 390, 
              collapsible = FALSE, solidHeader = TRUE,
              uiOutput(outputId = 'act_gen_info')
            ),
            box(
              title = 'Career Highlights', status = 'danger', width = 6, height = 390,
              collapsible = FALSE, solidHeader = TRUE,
              uiOutput(outputId = 'act_carir_hlt')
            )
          ),
          fluidRow(
            box(
              title = 'Statistics', status = 'success', width = 6,
              collapsible = TRUE, solidHeader = TRUE, 
              tabBox(
                title = NULL, width = NULL,
                tabPanel(
                  title = 'Movies', h3('Summary Statistics'), hr(), dataTableOutput(outputId = 'act_sumry'), br(),
                  h3('All Movies'), hr(), dataTableOutput(outputId = 'act_movies')
                ),
                tabPanel(
                  title = 'Collaborations',
                  box(width = NULL, uiOutput(outputId = 'act_collab_dir'), hr(), formattableOutput(outputId = 'act_ft_most_collab_dir')),
                  box(width = NULL, uiOutput(outputId = 'act_collab_act'), hr(), formattableOutput(outputId = 'act_ft_most_collab_act'))
                )
              )
            ),
            box(
              title = 'Visualizations', status = 'success', width = 6,
              collapsible = TRUE, solidHeader = TRUE, collapsed = FALSE,
              tabBox(
                title = NULL, width = NULL,
                tabPanel(
                  title = 'Ratings',
                  radioButtons('act_radio', label = 'Select rating system', choices = c('IMDb Rating', 'Metascore', 'Tomatometer'),
                               selected = 'IMDb Rating', inline = T),
                  box(width = NULL, h3('Movie Ratings'), hr(), plotlyOutput('act_movies_bar')),
                  box(width = NULL, h3('Movie Timeline'), hr(), plotlyOutput('act_timeline'))
                ),
                tabPanel(
                  title = 'Genres',
                  box(width = NULL, h3('Genres Played in', hr(), plotlyOutput('act_genres_loli')))
                )
              )
            )
          )
        ),
################################################################################
        ## Fun facts page
################################################################################
        tabItem(
          tabName = 'fun',
          fluidRow(
            column(width = 10, offset = 1, align = 'center', h1(tags$i('Fun Facts')), br()),
            column(
              width = 6,
              ## unlucky oscar nominees
              box(
                title = 'Unlucky Oscar Nominees', width = NULL, status = 'success', solidHeader = TRUE, collapsible = TRUE,
                bq('This section lists the directors and actors that received plenty of Oscar nominations but never landed an award.'),
                tabBox(
                  width = NULL,
                  tabPanel(title = 'Director', uiOutput(outputId = 'dir_unlucky'), dataTableOutput(outputId = 'dt_dir_unlucky')),
                  tabPanel(title = 'Actor', uiOutput(outputId = 'act_unlucky'), dataTableOutput(outputId = 'dt_act_unlucky'))
                )
              ),
              ## movies with polarizing ratings
              box(
                title = 'Movies with Polarizing Ratings', width = NULL, status = 'danger', solidHeader = TRUE, collapsible = TRUE,
                bq("User's opinions and Critics opinions often differ regarding the same movie. This section lists the most polarizing movies
                    according to their IMDb ratings and Metascores"),
                ## radioButtons('polar_radio_1', label = 'Select the first rating system', choices = c('IMDb_Rating', 'Metascore', 'Tomatometer'),
                ##              selected = 'IMDb_Rating', inline = TRUE),
                ## uiOutput('polar_radio_2'),
                ## formattableOutput('polar_top'),
                h3('Top 50 most polarizing movies'), hr(), dataTableOutput('polar_top'),
                h3('Polarizing movies by genre'), hr(), plotOutput('polar_bar')
              )
            ),
            ## oscar favorites
            column(
              width = 6,
              box(
                title = 'Oscar\'s Favorites', width = NULL, status = 'success', solidHeader = TRUE, collapsible = TRUE,
                bq('Here are some of directors and actors that frequently receive Oscar\'s recognition. Directors and Actors are ranked first by
                    number of awards and then by number of nominations'),
                tabBox(
                  width = NULL,
                  tabPanel(title = 'Director', uiOutput(outputId = 'dir_lucky'), dataTableOutput(outputId = 'dt_dir_lucky')),
                  tabPanel(title = 'Actor', uiOutput(outputId = 'act_lucky'), dataTableOutput(outputId = 'dt_act_lucky'))
                )
              ),
              box(
                title = 'Progression of Movie Genres', width = NULL, status = 'warning', solidHeader = TRUE, collapsible = TRUE,
                bq('Filming techniques have been evolving over the past century. This leads to the constant shift of popularity among film genres.'),
                p('Note: Click on a specific legend item to add or remove that genre from the plot. Double click to only look at that genre.'),
                ## h3('Genres per movie'), hr(), rbokehOutput('g_per_movie'),
                h3('Genre percentage over the years'), hr(), plotlyOutput('g_percent')
              ),
              box(
                title = 'Frequent Words in Plot Descriptions', width = NULL, status = 'info', solidHeader = TRUE, collapsible = TRUE,
                bq('Below is a bar chart showing some of the frequent words used in movie plots. The log ratio of this plot is computed by taking the base-2 log ratio of
                    the number of movies with top 25% ratings over that of movies with bottom 25% ratings.'), plotlyOutput('bar_word')
              )
            )
          )
        ),
################################################################################
        ## About page body 
################################################################################
        tabItem(
          tabName = 'about',
          fluidRow(
            column(width = 10, offset = 1, align = 'center', h1(tags$i('About')), br()),
            column(width = 10, offset = 1, includeMarkdown('./About.md'))
          )
        )
      )
    )
  )
)
