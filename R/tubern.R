#' \pkg{tubern} provides access to the YouTube Analytics and Reporting API
#'
#' @name tubern
#' @importFrom httr GET POST authenticate config stop_for_status upload_file content oauth_endpoints oauth_app oauth2.0_token
#' @docType package
NULL

#' Check if authentication token is in options
#'

yt_check_token <- function() {

	app_token = getOption('google_token')
    if (is.null(app_token)) stop("Please get a token using yt_oauth()")

}

#' 
#' Base POST AND GET functions. Not exported.

#'
#' GET
#' 
#' @param path path to specific API request URL 
#' @param query query list 
#' @param \dots Additional arguments passed to \code{\link[httr]{GET}}.
#' @return list

tubern_GET <- 
function(path, query=NULL, ...) {

	yt_check_token()

	req <- GET("https://youtubereporting.googleapis.com/", path= paste0("v1/", path), query=query, config(token = getOption("google_token")), ...)
	
	stop_for_status(req)
	res <- content(req)

	res
}

#'
#' POST
#' 
#' @param path path to specific API request URL 
#' @param query query list
#' @param body passing image through body 
#' @param \dots Additional arguments passed to \code{\link[httr]{GET}}.
#' 
#' @return list

tubern_POST <- 
function(path, query, body="", ...) {

	yt_check_token()
	
	req <- POST("https://youtubereporting.googleapis.com/", path= paste0("v1/", path),  body=body, query=query, config(token = getOption("google_token")), ...)
	stop_for_status(req)
	res <- content(req)

	res
}