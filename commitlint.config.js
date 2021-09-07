module.exports = {
    extends: ['@commitlint/config-conventional'],
    rules: {
        'body-max-line-length': [2, 'always', 220],
        'footer-max-line-length': [2, 'always', 220],
    },

};
