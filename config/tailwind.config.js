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
      screens: {
        'lg': '1080px',
        'md': '720px'
      },

      fontFamily: {
        'robo0%': ['Robo0%', 'sans-serif'],
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },

      animation: {
        slideRight: 'slide-right .3s ease-in-out',
        slideLeft: 'slide-left .3s ease-in-out',
        slideOut: 'slide-out .3s ease-in-out',
        slideDown: 'slide-down .3s ease-in-out',
        slideUp: 'slide-up .3s ease-in-out',
        spin: 'spin 1s ease-in-out infinite',
        shimmer: 'shimmer 1s ease-in-out'
      },

      keyframes: {
        'slide-right': {
          '0%': { opacity: 0, transform: 'translateX(-100%)' },
          '100%': { opacity: 95, transform: 'translateX(0%)' }
        },

        'slide-left': {
          '0%': { transform: 'translateX(100%)' },
          '100%': { transform: 'translateX(0%)' }
        },

        'slide-out': {
          '0%': { opacity: 95, transform: 'translateX(0%)' },
          '100%': { opacity: 0, transform: 'translateX(100%)' }
        },

        'slide-down': {
          '0%': { opacity: 0, transform: 'translateY(-100%)' },
          '100%': { opacity: 95, transform: 'translateY(0%)' }
        },

        'slide-up': {
          '0%': { opacity: 95, transform: 'translateY(0%)' },
          '100%': { opacity: 0, transform: 'translateY(-100%)' }
        },
        
        'spin': {
          '0%': { transform: 'rotate(0deg)' },
          '100%': { transform: 'rotate(360deg)' }
        },

        'shimmer': {
          // '0%': { transform: 'translateX(0%)' },
          '100%': { transform: 'translateX(100%)' }
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
