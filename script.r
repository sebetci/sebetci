#' It is the script file used to export the last Tweeter activity to the GitHub README file.
#'
#' @description
#' The tweetrmd library is used to convert recent Tweeter activity to HTML format. The rtweet
#' library provides R client functionality to interact with Twitter's (Streaming and REST) APIs.

#' Embed a Tweet in R Markdown HTML Outputs
#'
#' @description
#' Uses Twitter's [oembed](https://publish.twitter.com) API to embed a tweet
#' in R Markdown HTML outputs.
#'
#' @details
#' @references <https://developer.twitter.com/en/docs/tweets/post-and-engage/api-reference/get-statuses-oembed>
library(tweetrmd)

#' Collect Twitter data from R
#'
#' @description
#' rtweet provides users a range of functions designed to extract data from Twitter's REST and
#' streaming APIs.
#'
#' @details
#' It has three main goals:
#'  (1) Formulate and send requests to Twitter's REST and stream APIs.
#'  (2) Retrieve and iterate over returned data.
#'  (3) Wrangling data into tidy structures.
library(rtweet)

#' Creating Twitter authorization token(s).
#'
#' @description
#' Sends request to generate OAuth 1.0 tokens. Twitter also allows users to create user-only
#' (OAuth 2.0) access token. Unlike the 1.0 tokens, OAuth 2.0 tokens are not at all centered on
#' a host user. Which means these tokens cannot be used to send information (follow requests,
#' Twitter statuses, etc.). 
#'
#' @references <https://www.rdocumentation.org/packages/rtweet/versions/0.7.0/topics/create_token>
#'
#' @param None
#'
#' @return Twitter returns authorization token.
last_tweet_token <- function() {
    create_token(
        # Name of user created Twitter application.
        "github-readme-last-tweet",
        # Application API key    
        consumer_key = Sys.getenv("CONSUMER_KEY"),
        # Application API secret User-owned application must have Read and write access level and Callback URL of http://127.0.0.1:1410.
        consumer_secret = Sys.getenv("CONSUMER_SECRET"),
        # Access token as supplied by Twitter (apps.twitter.com)     
        access_token = Sys.getenv("ACCESS_TOKEN"),
        # Access secret as supplied by Twitter (apps.twitter.com)
        access_secret = Sys.getenv("ACCESS_SECRET"),
        # Logical indicating whether to save the created token as the default environment twitter token variable. 
        set_renv = FALSE
    )
}

# The twitter username is assigned to the variable.
handle <- "sercansebetci"

#' The timeline is assigned to the recent_tweets variable.
#' @references <https://www.rdocumentation.org/packages/rtweet/versions/0.7.0/topics/get_timeline>
recent_tweets <- get_timeline(handle, n=1, token=last_tweet_token())

# The last tweet image in the root directory is assigned to the temporary_image variable.
temporary_image <- "tweet.png"

#' Take or embed a screenshot of a tweet.
#' @references <https://rdrr.io/github/gadenbuie/tweetrmd/man/tweet_screenshot.html>
tweet_screenshot(
    # The URL for the tweet
    tweet_url(handle, recent_tweets$status_id),
    # Scale the tweet for a better quality screenshot.
    scale = 5, 
    # The maximum width of a rendered Tweet in whole pixels.
    maxwidth = 600,
    # When set to dark, the Tweet is displayed with light text over a dark background.
    theme = "light",
    # When set to true, "t", or 1 links in a Tweet are not expanded to photo, video, or link previews.
    hide_media = FALSE,
    # The image file is imported.
    file = temporary_image
)
