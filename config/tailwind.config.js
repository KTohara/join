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
      backgroundImage: {
        'join-splash': "url('join-node-bg.png')"
      },

      screens: {
        'lg': '1080px',
        'md': '720px'
      },

      fontFamily: {
        'roboto': ['Roboto', 'sans-serif'],
        'source': ['Source Code Pro', 'sans-serif'],
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },

      animation: {
        slideRight: 'slide-right .3s ease-in-out forwards',
        slideLeft: 'slide-left .3s ease-in-out forwards',
        slideOut: 'slide-out .3s ease-in-out forwards',
        slideDown: 'slide-down .3s ease-in-out forwards',
        slideUp: 'slide-up .3s ease-in-out forwards',
        'slide-in-up': 'slide-in-up .3s ease-in-out forwards',
        spin: 'spin 1s ease-in-out infinite',
        shimmer: 'shimmer .7s ease-in-out',
        fadeOut: 'fade-out 2s ease-in 2s forwards',
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
          '100%': { opacity: 0, transform: 'translateX(100%)', visibility: 'hidden' }
        },

        'slide-down': {
          '0%': { opacity: 0, transform: 'translateY(-100%)' },
          '100%': { opacity: 95, transform: 'translateY(0%)' }
        },

        'slide-up': {
          '0%': { opacity: 95, transform: 'translateY(0%)' },
          '100%': { opacity: 0, transform: 'translateY(-100%)' }
        },

        'slide-in-up': {
          '0%': { opacity: 0, transform: 'translateY(100%)' },
          '100%': { opacity: 95, transform: 'translateY(0%)' }
        },
        
        'spin': {
          '0%': { transform: 'rotate(0deg)' },
          '100%': { transform: 'rotate(360deg)' }
        },

        'shimmer': {
          '100%': { transform: 'translateX(100%)' }
        },

        'fade-out': {
          '100%': { opacity: 0, visibility: 'hidden' }
        }
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
  ]
}
