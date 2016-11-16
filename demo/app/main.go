// Package main is the CLI.
// You can use the CLI via Terminal.
package main

import (
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/ninnemana/devgroup-11-15-16/demo/app/db"
	"github.com/ninnemana/devgroup-11-15-16/demo/app/gin_html_render"
	"github.com/ninnemana/devgroup-11-15-16/demo/app/handlers/articles"
	"github.com/ninnemana/devgroup-11-15-16/demo/app/middlewares"
)

const (
	// Port at which the server starts listening
	Port = "7000"
)

func init() {
	db.Connect()
}

func main() {

	// Configure
	router := gin.Default()

	// Set html render options
	htmlRender := GinHTMLRender.New()
	htmlRender.Debug = gin.IsDebugging()
	htmlRender.Layout = "layouts/default"
	// htmlRender.TemplatesDir = "templates/" // default
	// htmlRender.Ext = ".html"               // default

	// Tell gin to use our html render
	router.HTMLRender = htmlRender.Create()

	router.RedirectTrailingSlash = true
	router.RedirectFixedPath = true

	// Middlewares
	router.Use(middlewares.Connect)
	router.Use(middlewares.ErrorHandler)

	// Statics
	router.Static("/public", "./public")

	// Routes

	router.GET("/", func(c *gin.Context) {
		c.Redirect(http.StatusMovedPermanently, "/articles")
	})

	// Articles
	router.GET("/new", articles.New)
	router.GET("/articles/:_id", articles.Edit)
	router.GET("/articles", articles.List)
	router.POST("/articles", articles.Create)
	router.POST("/articles/:_id", articles.Update)
	router.POST("/delete/articles/:_id", articles.Delete)

	// Start listening
	router.Run(":8080")
}
