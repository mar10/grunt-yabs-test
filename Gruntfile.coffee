###
Build scripts for yabs-test
###

# jshint directives for the generated JS:

###jshint node: true, unused: false ###

"use strict"

module.exports = (grunt) ->

  grunt.initConfig

    pkg:
        grunt.file.readJSON("package.json")

    jshint:
      all: [
        'Gruntfile.js'
        'tasks/*.js'
        '<%= nodeunit.tests %>'
        ]
      options:
        jshintrc: '.jshintrc'

    # Before generating any new files, remove any previously-created files.
    clean:
      tests: ['tmp']

    # Options for the 'yabs' task.
    yabs: {
      # options: {
      #   common: { // defaults for all tools
      #     manifests: ['package.json', 'testbower.json'],
      #   },
      # },
      release:
        # common: { // defaults for all tools
        # },
        run: {tasks: ['jshint'] }
        check: { clean: true, branch: ['master'] }
        bump: {}
        commit: {}
        tag: {}
        push: { tags: true, useFollowTags: false }
        # npmPublish: {},
        githubRelease:
          repo: "mar10/grunt-yabs-test", #// 'owner/repo'
          auth: {oauthTokenVar: 'GITHUB_OAUTH_TOKEN'},
          # auth: {usernameVar: 'GITHUB_USERNAME', passwordVar: 'GITHUB_PASSWORD'},
    #    tagName: 'v1.0.0',
    #    targetCommitish: null, //'master',
    #       // name: 'v{%= version %}',
    #       // body: 'Released {%= version %}',
          draft: false
          # prerelease: false,

        bump_develop:
          inc: 'prepatch'
        commit_develop:
          message: 'Bump for prerelease ({%= version %}) [ci skip]'
        push_develop: {}
      },
    #   gr: {
    #     // check: { clean: true, branch: ['master'] },
    #     bump_develop: { inc: 'zero' },
    #     githubRelease: {
    #       repo: "mar10/yabs-test", // 'owner/repo'
    #       // auth: {usernameVar: 'GITHUB_USERNAME', passwordVar: 'GITHUB_PASSWORD'},
    # //    tagName: 'v1.0.0',
    # //    targetCommitish: null, //'master',
    #       // name: 'v{%= version %}',
    #       // body: 'Released {%= version %}',
    #       draft: false,
    #       prerelease: true,
    #     },
    #   }
    # },

    # Unit tests.
    nodeunit:
      tests: ['test/*_test.js']


  # Load "grunt*" dependencies
  for key of grunt.file.readJSON("package.json").devDependencies
      grunt.loadNpmTasks key  if key isnt "grunt" and key.indexOf("grunt") is 0

  # Actually load this plugin's task(s).
  grunt.loadTasks 'tasks';

  # Whenever the "test" task is run, first clean the "tmp" dir, then run this
  # plugin's task(s), then test the result.
  grunt.registerTask 'test', ['clean', 'yabs', 'nodeunit']

  # By default, lint and run all tests.
  grunt.registerTask "default", ["jshint", "test"]

  # grunt.registerTask('build', [
  #   'yabs:build',
  #   ]);
#
