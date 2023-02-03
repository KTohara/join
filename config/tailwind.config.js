const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    extend: {
      fontFamily: {
        'roboto': ['Roboto', 'sans-serif'],
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
      animation: {
        slideRight: 'slide_right .4s ease-in-out',
        slideLeft: 'slide_left .4s ease-in-out',
        slideOut: 'slide_out .4s ease-in-out',
        spin: 'spin 1s ease-in-out infinite'
      },
      keyframes: {
        slide_right: {
          '0%': { transform: 'translateX(-100%)' },
          '100%': { transform: 'translateX(0%)' },
        },
        slide_left: {
          '0%': { 
            overflow: 'hidden',
            transform: 'translateX(100%)'
          },
          '100%': { 
            overflow: 'hidden',
            transform: 'translateX(0%)'
          },
        },
        slide_out: {
          '0%': { transform: 'translateX(-0%)' },
          '100%': { transform: 'translateX(100%)' },
        },
        spin: {
          '0%': { transform: 'rotate(0deg)'},
          '100%': { transform: 'rotate(360deg)'}
        },
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
  ]
}
