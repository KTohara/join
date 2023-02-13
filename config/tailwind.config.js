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
        'slide-in-right': 'slide-in-right .3s ease-in-out forwards',
        'slide-out-right': 'slide-out-right .3s ease-in-out forwards',
        'slide-out-left': 'slide-out-left .3s ease-in-out forwards',
        'slide-in-down': 'slide-in-down .3s ease-in-out forwards',
        'slide-in-up': 'slide-in-up .3s ease-in-out forwards',
        'spin': 'spin 1s ease-in-out infinite',
        'shimmer': 'shimmer .7s ease-in-out',
        'fade-out': 'fade-out 2s ease-in 2s forwards',
      },

      keyframes: {
        'slide-in-right': {
          '0%': { opacity: 0, transform: 'translateX(-100%)' },
          '100%': { opacity: 95, transform: 'translateX(0%)' }
        },

        'slide-out-right': {
          '0%': { opacity: 95, transform: 'translateX(0%)' },
          '100%': { opacity: 0, transform: 'translateX(100%)', visibility: 'hidden' }
        },

        'slide-out-left': {
          '0%': { opacity: 95, transform: 'translateX(0%)' },
          '100%': { opacity: 0, transform: 'translateX(-100%)', visibility: 'hidden' }
        },

        'slide-in-down': {
          '0%': { opacity: 0, transform: 'translateY(-100%)' },
          '100%': { opacity: 95, transform: 'translateY(0%)' }
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
