module.exports = {
    purge: {
        enabled: process.env.NODE_ENV !== 'development',
        options: {
            safelist: ["type"],
        },
        content: ["./app/components/**/*.*", "./app/views/**/*.*"]
    },
    darkMode: false, // or 'media' or 'class'
    theme: {
        extend: {},
    },
    variants: {
        extend: {},
    },
    plugins: [require("@tailwindcss/forms")],
};
