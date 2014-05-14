/**
 * Deployup Grunt File
 */

var coffeeIncludes = require('./src/coffee/includes.js');

module.exports  = function(grunt) {

  grunt.initConfig({

    coffee : {
      app : {
        options : {
          sourceMap : true,
          sourceMapDir : 'dist/',
          bare : true
        },
        files : {
          "dist/app.js" : coffeeIncludes
        }
      }
    },

    stylus : {
      app : {
        files : {
          'dist/style.css' : 'src/styl/style.styl'
        }
      }
    },

    copy : {
      vendor : {
        flatten : true,
        expand: true,
        src : 'src/vendor/**/*',
        dest : 'dist/vendor/',
        filter : 'isFile'
      },
      index : {
        src : 'src/index.html',
        dest : 'dist/index.html'
      },
      images : {
        flatten : true,
        expand : true,
        src : 'src/img/**/*',
        dest : 'dist/img/',
        filter : 'isFile'
      },
      pkgjson : {
        src  : 'package.json',
        dest : 'dist/package.json'
      }
    },

    watch : {
      files : ['./src/**/*'],
      tasks : ['reloadIncludes','coffee', 'stylus', 'copy']
    },

    nodewebkit : {
      options: {
        build_dir: './appbuilds',
        mac: true,
        win: false,
        linux32: false,
        linux64: false
      },
      src: ['./dist/**/*']
    }

  });

  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-coffee');
  grunt.loadNpmTasks('grunt-contrib-stylus');
  grunt.loadNpmTasks('grunt-contrib-copy');
  grunt.loadNpmTasks('grunt-node-webkit-builder');

  grunt.registerTask('default', ['coffee', 'stylus', 'copy', 'watch']);
  grunt.registerTask('buildApp', ['coffee', 'stylus', 'copy', 'nodewebkit'])

  grunt.registerTask('reloadIncludes', '', function(){
    console.log("Reloading include files...");
    coffeeIncludes           = require('./src/coffee/includes.js');
  });
}
