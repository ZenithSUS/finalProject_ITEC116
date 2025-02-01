document.addEventListener('DOMContentLoaded', () => {
    // Theme Elements
    const header = document.querySelector('header');
    const body = document.body;
    const root = document.documentElement;
    const style = getComputedStyle(root);
    const primaryColor = style.getPropertyValue('--primary-color'); 
    const secondaryColor = style.getPropertyValue('--secondary-color');
    const lightColor = style.getPropertyValue('--light-color');
    const darkColor = style.getPropertyValue('--dark-color');
    const buttonLightColor = style.getPropertyValue('--button-color');
    const buttonHoverLightColor = style.getPropertyValue('--button-hover-color');
    const buttonDarkColor = style.getPropertyValue('--dark-mode-button-color');
    const buttonHoverDarkColor = style.getPropertyValue('--dark-mode-button-hover-color');
    const navHoverLightColor = style.getPropertyValue('--nav-hover-color');
    const navHoverDarkColor = style.getPropertyValue('--nav-hover-dark-color');
    const lightModeImagebg = 'src/images/abandon.jpg';
    const darkModeImageBg = 'src/images/waves.jpg';
    
    // Icons in the dashbord
    const userIcon = document.querySelector('#user-icon');
    const postIcon = document.querySelector('#post-icon');
    const groupIcon = document.querySelector('#group-icon');
    const commentIcon = document.querySelector('#comment-icon');

    // Set Theme Elements
    const applyMode = (isDarkMode) => {
        header.style.color = lightColor;
        root.style.setProperty('--dark-color', isDarkMode ? lightColor : darkColor);
        root.style.setProperty('--light-color', isDarkMode ? darkColor : lightColor);
        root.style.setProperty('--primary-color', isDarkMode ? secondaryColor : primaryColor);
        root.style.setProperty('--secondary-color', isDarkMode ? darkColor : secondaryColor);
        root.style.setProperty('--button-color', isDarkMode ? buttonDarkColor: buttonLightColor);
        root.style.setProperty('--button-hover-color', isDarkMode ? buttonHoverDarkColor : buttonHoverLightColor);
        root.style.setProperty('--nav-hover-color', isDarkMode ? navHoverDarkColor : navHoverLightColor);
        body.style.backgroundImage = `url(${isDarkMode ? darkModeImageBg : lightModeImagebg})`;

        // If icons exist
        if(userIcon) userIcon.src = isDarkMode ? 'src/ui/icons8-user-60-dark.png' : 'src/ui/icons8-user-60.png';
        if(postIcon) postIcon.src = isDarkMode ? 'src/ui/icons8-post-64-dark.png' : 'src/ui/icons8-post-64.png';
        if(groupIcon) groupIcon.src = isDarkMode ? 'src/ui/icons8-group-64-dark.png' : 'src/ui/icons8-group-64.png';
        if(commentIcon) commentIcon.src = isDarkMode ? 'src/ui/icons8-comment-50-dark.png' : 'src/ui/icons8-comment-50.png';
    }
    
    if(theme == 1){
        applyMode(true);
    } else {
       applyMode(false);
    }

    const applyFont = (font) => {
        switch (font) {
            case 'fonts1':
                root.style.setProperty('--font-style', 'var(--font-style1)');
                break;
            case 'fonts2':
                root.style.setProperty('--font-style', 'var(--font-style2)');
                break;
            case 'fonts3':
                root.style.setProperty('--font-style', 'var(--font-style3)');
                break;
            default:
                root.style.setProperty('--font-style', 'var(--font-style1)');
        }
    };

    applyFont(font_style);
});