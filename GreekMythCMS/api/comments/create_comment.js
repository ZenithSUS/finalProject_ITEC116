document.addEventListener('DOMContentLoaded', async () => {
    const form = document.querySelector('.form-container form');
    const createButton = document.querySelector('#Create');
    const cancelButton = document.querySelector('#CancelCreate');

    // Fetch user data
    const fetchUsers = await postRequest(users_url, token);
    const userData = fetchUsers.data;
    console.log(userData);

    // Fetch post data
    const fetchPosts = await postRequest(posts_url, token);
    const postData = fetchPosts.data;
    console.log(postData);
    
    // Create options
    const usernameOptions = document.querySelector('#usernameCreate');
    const postOptions = document.querySelector('#postTitleCreate');
    const parentCommentOptions = document.querySelector('#parentCommentCreate');

    usernameOptions.innerHTML = ` <option value=''>Select</option> ` + userData.map(username => `
            <option value='${username.user_id}'>${username.username}</option>
    `).join(' ');

    postOptions.innerHTML = ` <option value=''>Select</option> ` + postData.map(post => `
            <option value='${post.post_id}'>${post.username} - ${post.title}</option>
    `).join(' ');

    postOptions.addEventListener('change', async (e) => {
        const postId = e.target.value;

        if (postId) {
            const fetchComments = await getRequest(comments_url, postId, token, 'getParentComments');
            const commentData = fetchComments.data;

            if(fetchComments.status !== 404){
                console.log(commentData);
            } 

            parentCommentOptions.innerHTML = commentData ? ` <option value=''>Select</option> ` + commentData.map(comment => `
                    <option value='${comment.comment_id}'>${comment.username} - ${comment.content}</option>
            `).join(' ') : `<option value=''>Select</option>`;
        } else {
            parentCommentOptions.innerHTML = `<option value=''>Select</option>`;
        }
    });
    
    // Create comment function 
    createButton.addEventListener('click', async (e) => {
        e.preventDefault();
        const userId = form.usernameCreate.value ? form.usernameCreate.value.toString() : "";
        const postId = form.postTitleCreate.value ? form.postTitleCreate.value.toString() : "";
        const parentId = form.parentCommentCreate.value ? form.parentCommentCreate.value.toString() : "";
        const content = form.contentCreate.value ? form.contentCreate.value : "";
        const formData = new FormData();

        formData.append('user_id', userId);
        formData.append('post_id', postId);
        formData.append('parent_id', parentId);
        formData.append('content', content);
        formData.append('type', 'createComment');

        const response = await createRequest(comments_url, formData, token);

        if (response.status < 300) {
            createButton.disabled = true;
            window.location.href = `navigate/comments.html?updated=${true}&message=${response.message}`;
        } else {
            console.log(response);
            checkErrors(response.error);
        }
    });

    // If the user clicks cancel
    cancelButton.addEventListener('click', (e) => {
        e.preventDefault();
        window.location.href = 'navigate/comments.html';
    });

});