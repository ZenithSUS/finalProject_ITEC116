// Endpoints for GreekMyth API
const posts_url = "http://localhost/finalProject_ITEC116/GreekMythApi/api/posts.php";
const users_url = "http://localhost/finalProject_ITEC116/GreekMythApi/api/users.php";
const groups_url = "http://localhost/finalProject_ITEC116/GreekMythApi/api/groups.php";
const comments_url = "http://localhost/finalProject_ITEC116/GreekMythApi/api/comments.php";


// Get the current URL
const current_URL_Location = () => {
  const pathname = window.location.pathname;
  const lastPathSegment = pathname.split('/').pop();
  return lastPathSegment;
}

// Check the current URL and display the data
const checkURL = (currentURL) => {
  if(currentURL === "index.html" || currentURL === "") {
    indexDisplayData(fetchedData);
  }
  if(currentURL === "users.html") {
    userDisplayData(fetchedData.users);
  }
  if(currentURL === "posts.html"){
    postDisplayData(fetchedData.posts);
  }
  if(currentURL === "comments.html"){
    commentDisplayData(fetchedData.comments);
  }
  if(currentURL === "groups.html"){
    groupDisplayData(fetchedData.groups);
  }
}


// Get User data from local storage
const token = localStorage.getItem('token');
const user_id = localStorage.getItem('user_id');
const theme = localStorage.getItem('theme');
const font_style = localStorage.getItem('font-style');

// Check if the user is logged in
if (!token) {
  window.location.href = 'auth/login.html';
}

// Object to store the fetched data
let fetchedData;

// Fetch Admin Data
async function fetchAdminData() {
    try {
      const response = await fetch('http://localhost/finalProject_ITEC116/GreekMythApi/api/users.php?user_id=' + user_id, {
          method: "GET",
          headers: {
              "Content-Type": "application/json",
              Authorization: `Bearer ${token}`,
          }
      });
      const data = await response.json();
      document.getElementById('username').innerHTML = data.data[0].username;
      document.getElementById('profile-pic').src = data.data[0].image_src;
      return data;
    } catch (error) {
      console.error('Error fetching user data:', error);
      return null;
    }
  }

  
const fetchApi = async (url, page = 1, limit = 10) => {
    let fetchurl = '';
    if (current_URL_Location() !== "index.html" && current_URL_Location() !== "") {
        fetchurl = `${url}?page=${page}&limit=${limit}`;
    } else {
      fetchurl = url;
    }
    
    const response = await fetch(fetchurl, {
        method: "POST",
        headers: {
            "Content-Type": "application/json",
            Authorization: `Bearer ${token}`
        },
    });

    const data = await response.json();
    console.log(data)
    return data;
}


// Fetch the Endpoints at the same time
const fetchAllApis = async (page) => {
    try {
      if(current_URL_Location() === "index.html" || current_URL_Location() == ""){
        // Deconstruct the data fetched from the API
      const [postData, userData, groupData, commentData] = await Promise.all([
        
        fetchApi(posts_url),
        fetchApi(users_url),
        fetchApi(groups_url),
        fetchApi(comments_url),
      ]);
      
      // Store the fetched data in an object
      fetchedData = {
          posts: postData, 
          users: userData, 
          groups : groupData,
          comments: commentData
        };
      } 

      if(current_URL_Location() === "groups.html"){
        const groupData = await fetchApi(groups_url, page);
        fetchedData = { groups: groupData }
      }

      if(current_URL_Location() === "users.html"){
        const userData = await fetchApi(users_url, page);
        fetchedData = { users: userData };
      }

      if(current_URL_Location() === "posts.html"){
        const postData = await fetchApi(posts_url, page);
        fetchedData = { posts: postData }; 
      }

      if(current_URL_Location () === "comments.html"){
        const commentData = await fetchApi(comments_url, page);
        fetchedData = { comments: commentData };
      }
      
    
    } catch (error) {
      console.error("Error fetching data:", error);
    }
  };

  let currentPage = 1;
  
  async function fetchData(page = currentPage) {
    try {
      await fetchAllApis(page);

      if(fetchAllApis()){
        const currentURL = current_URL_Location();
        checkURL(currentURL);
        if(fetchedData) {
          console.log("Fetched data:", fetchedData);
        }
        
      }
    } catch (error) {
      console.error("Failed to fetch data:", error);
    }
  }

  fetchData();
  fetchAdminData();


// Santize Input for HTML to prevent XSS
const santizeInput = (input) => {
    return input.replace(/&/g, '&amp;')
                .replace(/>/g, "&gt;")
                .replace(/</g, '&lt;')
                .replace(/"/g, '&quot;')
                .replace(/'/g, '&#39;');
}

// Display Index Data if the current URL is "index.html" or ""
const indexDisplayData = (data) => {

  const overallData = (data) => {
      const totalUsers = document.getElementById('totalUsers');
      const totalPosts= document.getElementById('totalPosts');
      const totalGroups = document.getElementById('totalGroups');
      const totalComments = document.getElementById('totalComments');

      totalUsers.innerHTML = data.users.data.length ? data.users.data.length : "N/A";
      totalPosts.innerHTML = data.posts.data.length ? data.posts.data.length : "N/A";
      totalGroups.innerHTML = data.groups.data.length ? data.groups.data.length : "N/A";
      totalComments.innerHTML = data.comments.data.length ? data.comments.data.length : "N/A";
  }
  
  const recentPosts = (posts) => {
      const postsContainer = document.getElementById('recentPosts-container');
      postsContainer.innerHTML = posts.data.slice(0, 5).map(post => `
        <div class="post">
          <div class="post-header">
            <h3><a href='admin/posts/view_post.html?id=${post.post_id}' class="dashboard-post-title">${elipsisContent(post.title)}</a></h3>
            <h3>${DateFormat(post.created_at)}</h3>
          </div>
        </div>
      `).join(' ');
    };

  const mostFriends = (friends) => {
    const mostFriendsContainer = document.getElementById('mostfriends-container');
    mostFriendsContainer.innerHTML = friends.slice(0, 10).map((friend, index) => `
        <div class="friends">
          <h3>Top ${index + 1}: <a href='admin/users/view_user.html?id=${friend.user_id}'>${friend.username}</a></h3>
          <h3>Friends: ${friend.totalFriends}</h3>
        </div>
      `).join('');
  }
  
  const DateFormat = (date) => {
      const newDate = new Date(date);
      dateFormat = newDate.toLocaleString('default', { month: 'short' }) + ' ' + newDate.getDate() + ' '  + newDate.getFullYear();
      return dateFormat;
  }

  const sortTotalFriends = (friends) => {
    return friends.sort((a, b) => b.totalFriends - a.totalFriends)
  }

  const elipsisContent = (content) => {
    let elipsisText = " ";
    elipsisText = content.length <= 20 ? content : content.substr(0, 15) + '...';
    return elipsisText;
}

  if(data){
    overallData(data);

    if(data.posts.data.length > 0){
      recentPosts(data.posts);
    } else {
      const recentPostsContainer = document.getElementById('recentPosts-container');
      recentPostsContainer.innerHTML = `<h3>No recent posts</h3>`
    }

    if(data.users.data.length > 0){
      mostFriends(sortTotalFriends(data.users.data));
    } else {
      const mostFriendsContainer = document.getElementById('mostfriends-container');
      mostFriendsContainer.innerHTML = `<h3>No recent top friends</h3>`
    }
  }
}

// Display User Data if the current URL is "users.html"
const userDisplayData = (user, page = currentPage) =>{

  const userTableData = (users) => {
      const tableBody = document.querySelector('tbody');
      const type = "user";

      tableBody.innerHTML = users.data.map(user => `
          <tr>
              <td>${user.username}</td>
              <td>${user.email}</td>
              <td><img src="${user.profile_pic}" alt="No Image"></td>
              <td>${user.totalFriends}</td>
              <td>${user.bio != "" && user.bio != null ? user.bio : "No bio"}</td>
              <td>${DateFormat(user.joined_at)}</td>
              <td class='user-options'>
                  <a class='edit' href='admin/users/edit_user.html?id=${user.user_id}'>Edit</a>
                  <a class='view' href='admin/users/view_user.html?id=${user.user_id}'>View</a>
                  <a class='delete' data-id=${user.user_id}>Delete</a>
              </td>
          </tr>    
          
      `).join(' ');


      const modalChange = document.getElementById('modal-change');
      const modalMessage = document.getElementById('confirm-message');
      const confirmBtn = document.getElementById('confirmchangebtn');
      const cancelBtn = document.getElementById('cancelchangebtn');

      // Get the delete Button and add an event
      const deleteButton = document.querySelectorAll('.delete');
      deleteButton.forEach(button => {
          button.addEventListener('click', () => {
              modalChange.style.display = 'block';
              modalMessage.textContent = 'Are you sure do you want do delete this user?';

              confirmBtn.addEventListener('click', async () => {
                  const response = await deleteRequest(users_url, button.dataset.id, type, token);
                  if(response.status < 300) {
                      window.location.href = `navigate/users.html?updated=${true}&message=${response.message}`;
                  } else {
                      console.error('Error deleting data:', response.message)
                  }
              });

              cancelBtn.addEventListener('click', () => {
                  modalChange.style.display = 'none';
                  modalMessage.textContent = '';
              });

          });
      })
  }

  const handleNoData = () => {
      const tableBody = document.querySelector('tbody');
      tableBody.innerHTML = `
          <tr>
              <td rowspan="6">No Users Available</td>
          </tr>
      `;
  }

  const DateFormat = (date) => {
      const newDate = new Date(date);
      const dateFormat = newDate.toLocaleString('default', { month: 'short' }) + ' ' + newDate.getDate() + ' '  + newDate.getFullYear();
      return dateFormat;
  }

  if(user && user.status < 300){
      if(user.data.length === 0){
          handleNoData();
          return;
      }

      userTableData(user);

      // Add pagination controls 
      const paginationContainer = document.querySelector('.pagination-users'); 
      paginationContainer.innerHTML = ''; // Clear previous pagination

      // Create "Previous" button
      const prevButton = document.createElement('button');
      prevButton.textContent = 'Previous';
      prevButton.onclick = () => { 
          if(currentPage > 1){
              currentPage++;
              fetchData(currentPage); 
          }
      };

      if (page === 1) {
          prevButton.disabled = true;
      }
      paginationContainer.appendChild(prevButton);

  
      const nextButton = document.createElement('button');
      nextButton.textContent = 'Next';
      nextButton.onclick = () => { 
          fetchData(page + 1); 
      };
      const totalPages = user.totalPages; // Get total pages from API response


      if (currentPage === totalPages) { 
          nextButton.disabled = true;
      }
      paginationContainer.appendChild(nextButton);

      document.getElementById('pagination-number').innerHTML = `
          <h3>Page ${currentPage} of ${totalPages}</h3>
      `;
  }
  
}

// Display Post Data if the current URL is "posts.html"s
const postDisplayData = (posts, page = currentPage) => {

  const postTableData = (posts) => {
      const tableBody = document.querySelector('tbody');
      const formData = new FormData();
      const type = "delete";
      tableBody.innerHTML = posts.map(post => `
         <tr>
              <td>${post.username}</td>
              <td>${elipsisContent(post.title)}</td>
              <td class='post-content'>${elipsisContent(post.content ? post.content : "N/A")}</td>
              <td>${DateFormat(post.created_at)}</td>
              <td>${post.name != null ? post.name : "N/A"}</td>
              <td>${post.status === 1 ? "Permited" : "Disabled"}</td>
              <td class='user-options'>
                  <a class='view' href='admin/posts/view_post.html?id=${post.post_id}'>View</a>
                  <a class='${post.status === 1 ? "disable" : "enable"}' data-id=${post.post_id}>${post.status === 1 ? "Disable" : "Enable"}</a>
                  <a class='delete' data-id=${post.post_id}>Delete</a>
              </td>
          </tr>    
          
      `).join(' ');

      const modalChange = document.getElementById('modal-change');
      const modalMessage = document.getElementById('confirm-message');
      const confirmBtn = document.getElementById('confirmchangebtn');
      const cancelBtn = document.getElementById('cancelchangebtn');

      // Get the disable button and add an event
      const disableButton = document.querySelectorAll('.disable');
      disableButton.forEach(button => {
          button.addEventListener('click', () => {
              modalChange.style.display = 'block';
              modalMessage.textContent = 'Are you sure do you want to disable this post?';

              confirmBtn.addEventListener('click', async () => {
                  formData.append('type', 'disable');
                  const response = await editRequest(posts_url, button.dataset.id, formData, token);
                  if(response.status < 300) {
                      window.location.href = `navigate/posts.html?updated=${true}&message=${response.message}`;
                  } else {
                      console.error('Error deleting data:', response.message)
                  }
              });

              cancelBtn.addEventListener('click', () => {
                  modalChange.style.display = 'none';
                  modalMessage.textContent = '';
              });

          });
      });

       // Get the disable button and add an event
       const enableButton = document.querySelectorAll('.enable');
       enableButton.forEach(button => {
          button.addEventListener('click', () => {
              modalChange.style.display = 'block';
              modalMessage.textContent = 'Are you sure do you want to enable this post?';

              confirmBtn.addEventListener('click', async () => {
                  formData.append('type', 'enable');
                  const response = await editRequest(posts_url, button.dataset.id, formData, token);
                  if(response.status < 300) {
                      window.location.href = `navigate/posts.html?updated=${true}&message=${response.message}`;
                  } else {
                      console.error('Error deleting data:', response.message)
                  }
              });

              cancelBtn.addEventListener('click', () => {
                  modalChange.style.display = 'none';
                  modalMessage.textContent = '';
              });

          });
       });

      // Get the delete button and add an event
      const deleteButton = document.querySelectorAll('.delete')
      deleteButton.forEach(button => {
          button.addEventListener('click', () =>{
              modalChange.style.display = 'block';
              modalMessage.textContent = 'Are you sure do you want do delete this post?';

              confirmBtn.addEventListener('click', async() => {
                  const response = await deleteRequest(posts_url, button.dataset.id, type, token);
                  if(response.status < 300) {
                      window.location.href = `navigate/posts.html?updated=${true}&message=${response.message}`;
                  } else {
                      console.error('Error deleting data:', response.message)
                  }
              });
              
              cancelBtn.addEventListener('click', () => {
                  modalChange.style.display = 'none';
                  modalMessage.textContent = '';
              });
              
          });
      });
  }

  const handleNoData = () => {
      const tableBody = document.querySelector('tbody');
      tableBody.innerHTML = `
          <tr>
              <td colspan="7">No Posts Available</td>
          </tr>
      `;
  }

  const sortPosts = (posts) => {
      return posts.data.sort((a, b) => b.created_at - a.created_at)
  }

  const elipsisContent = (content) => {
      let elipsisText = " ";
      elipsisText = content.length <= 15 ? content : content.substr(0, 30) + '...';
      return elipsisText;
  }

  const DateFormat = (date) => {
      const newDate = new Date(date);
      const dateFormat = newDate.toLocaleString('default', { month: 'short' }) + ' ' + newDate.getDate() + ' ' + newDate.getFullYear();
      return dateFormat;
  }

  if(posts && posts.status < 300){
      if (posts.data.length === 0) {
          handleNoData();
          return;
      }

      const postData = sortPosts(posts);
      postTableData(postData);

      const paginationContainer = document.querySelector('.pagination-posts')
      paginationContainer.innerHTML = '';

      const prevButton = document.createElement('button');
      prevButton.textContent = 'Previous';
      prevButton.onclick = () => {
          if(currentPage > 1){
              currentPage--;
              fetchData(currentPage);
          }
      }

      if (page === 1) {
          prevButton.disabled = true;
      }
      paginationContainer.appendChild(prevButton);

      const nextButton = document.createElement('button');
      nextButton.textContent = 'Next';
      nextButton.onclick = () => {
          if(currentPage < totalPages){
              currentPage++;
              fetchData(currentPage);
          }
      }
      

      const totalPages = posts.totalPages;

      if(currentPage === totalPages){
          nextButton.disabled = true;
      }

      paginationContainer.appendChild(nextButton);

      document.getElementById('pagination-number').innerHTML = `
          <h3>Page ${currentPage} of ${totalPages}</h3>
      `;
  } else {
      handleNoData();
  }
}

// Display Group Data if the current URL is "groups.html"
const groupDisplayData = (groups, page = currentPage) => {

  const groupsTableData = (groups) => {
      const tableBody = document.querySelector('tbody');
      const formData = new FormData();
      const type = "delete";

      tableBody.innerHTML = groups.map(group => `
         <tr>
              <td>${group.name}</td>
              <td>${elipsisContent(group.description)}</td>
              <td>${group.creator === "Default" ? group.creator = "Admin" : group.username}</td>
              <td><img src="${group.image_url}" alt="No Image"></td>
              <td>${group.status === 1 ? "Permited" : "Disabled"}</td>
              <td class='user-options'>
                  <a class='view' href='admin/groups/view_group.html?id=${group.greek_id}'>View</a>
                  <a class='${group.status === 1 ? "disable" : "enable"}' data-id=${group.greek_id}>${group.status === 1 ? "Disable" : "Enable"}</a>
                  <a class='delete' data-id=${group.greek_id}>Delete</a>
              </td>
          </tr>    
          
      `).join(' ');

      const modalChange = document.getElementById('modal-change');
      const modalMessage = document.getElementById('confirm-message');
      const confirmBtn = document.getElementById('confirmchangebtn');
      const cancelBtn = document.getElementById('cancelchangebtn');

      const disableButton = document.querySelectorAll('.disable');
      disableButton.forEach(button => {
          button.addEventListener('click', () => {
              modalChange.style.display = 'block';
              modalMessage.textContent = 'Are you sure do you want do disable this group?';

              confirmBtn.addEventListener('click', async () => {
                  formData.append('type', 'disable');
                  const response = await editRequest(groups_url, button.dataset.id, formData, token);
                  if(response.status < 300) {
                      window.location.href = `navigate/groups.html?updated=${true}&message=${response.message}`;
                  } else {
                      console.error('Error deleting data:', response.message)
                  }
              });

              cancelBtn.addEventListener('click', () => {
                  modalChange.style.display = 'none';
                  modalMessage.textContent = '';
              });
          });
      });

      const enableButton = document.querySelectorAll('.enable');
      enableButton.forEach(button => {
          button.addEventListener('click', () => {
              modalChange.style.display = 'block';
              modalMessage.textContent = 'Are you sure do you want do enable this group?';

              confirmBtn.addEventListener('click', async () => {
                  formData.append('type', 'enable');
                  const response = await editRequest(groups_url, button.dataset.id, formData, token);
                  if(response.status < 300) {
                      window.location.href = `navigate/groups.html?updated=${true}&message=${response.message}`;
                  } else {
                      console.error('Error deleting data:', response.message)
                  }
              });

              cancelBtn.addEventListener('click', () => {
                  modalChange.style.display = 'none';
                  modalMessage.textContent = '';
              });

          });
      })

      const deleteButton = document.querySelectorAll('.delete');
      deleteButton.forEach(button => {
          button.addEventListener('click', () => {
              modalChange.style.display = 'block';
              modalMessage.textContent = 'Are you sure do you want do delete this group?';

              confirmBtn.addEventListener('click', async () => {
                  const response = await deleteRequest(groups_url, button.dataset.id, type, token);
                  if(response.status < 300){
                      window.location.href = `navigate/groups.html?updated=${true}&message=${response.message}`;
                  } else {
                      console.error('Error deleting data:', response.message)
                  }
              });

              cancelBtn.addEventListener('click', () => {
                  modalChange.style.display = 'none';
                  modalMessage.textContent = '';
              });
              
          });
      }); 
  }

  const handleNoData = () => {
      const tableBody = document.querySelector('tbody');
      tableBody.innerHTML = `
          <tr>
              <td rowspan="6">No Groups Available</td>
          </tr>
      `;
  }

  const elipsisContent = (content) => {
      let elipsisText = " ";
      elipsisText = content.length <= 15 ? content : content.substr(0, 30) + '...';
      return elipsisText;
  }

  const sortGroups = (groups) => {
      return groups.data.sort((a,b) => a.name.localeCompare(b.name));
  }

  if(groups && groups.status < 300){
      if (groups.data.length === 0) {
          handleNoData();
          return;
      }
      
      const groupdata = sortGroups(groups)
      groupsTableData(groupdata)

      // Add pagination controls 
      const paginationContainer = document.querySelector('.pagination-groups'); 
      paginationContainer.innerHTML = ''; // Clear previous pagination

      // Create "Previous" button
      const prevButton = document.createElement('button');
      prevButton.textContent = 'Previous';
      prevButton.onclick = () => { 
          if (currentPage > 1) {
              currentPage--;
              fetchData(currentPage); 
          }
      };
      if (page === 1) {
          prevButton.disabled = true;
      }
      paginationContainer.appendChild(prevButton);

  
      const nextButton = document.createElement('button');
      nextButton.textContent = 'Next';
      nextButton.onclick = () => { 
          if (currentPage < totalPages) {
              currentPage++;
              fetchData(currentPage); 
          }
      };

      const totalPages = groups.totalPages; // Get total pages from API response

      if (currentPage === totalPages) { 
          nextButton.disabled = true;
      }
      paginationContainer.appendChild(nextButton);

      document.getElementById('pagination-number').innerHTML = `
          <h3>Page ${currentPage} of ${totalPages}</h3>
      `;
  }
 
}

// Display Comments Data if the current page is comments.html
const commentDisplayData = (comments, page = currentPage) => {

  const commentsTableData = (comments) => {
      const tableBody = document.querySelector('tbody');
      const formData = new FormData();
      const type = "delete";

      tableBody.innerHTML = comments.map(comment => `
       <tr>
              <td>${comment.username}</td>
              <td>${elipsisContent(comment.content)}</td>
              <td>${DateFormat(comment.created_at)}</td>
              <td>${comment.likes}</td>
              <td>${comment.dislikes}</td>
              <td>${comment.name !== null ? comment.name : "N/A"}</td>
              <td class='user-options'>
                  <a class='view' href='admin/comments/view_comment.html?id=${comment.comment_id}'>View</a>
                  <a class='${comment.status === 1 ? "disable" : "enable"}' data-id=${comment.comment_id}>${comment.status === 1 ? "Disable" : "Enable"}</a>
                  <a class='delete' data-id=${comment.comment_id}>Delete</a>
              </td>
          </tr>    
          
      `).join(' ');

      const modalChange = document.getElementById('modal-change');
      const modalMessage = document.getElementById('confirm-message');
      const confirmBtn = document.getElementById('confirmchangebtn');
      const cancelBtn = document.getElementById('cancelchangebtn');

      // Get the disable button and add an event
      const disableButton = document.querySelectorAll('.disable');
      disableButton.forEach(button => {
          button.addEventListener('click', () => {
              modalChange.style.display = 'block';
              modalMessage.textContent = 'Are you sure do you want to disable this comment?';

              confirmBtn.addEventListener('click', async () => {
                  formData.append('type', 'disable');
                  const response = await editRequest(comments_url, button.dataset.id, formData, token);
                  if(response && response.status < 300) {
                      window.location.href = `navigate/comments.html?updated=${true}&message=${response.message}`;
                  } else {
                      console.error('Error deleting data:', response.message)
                  }
              });

              cancelBtn.addEventListener('click', () => {
                  modalChange.style.display = 'none';
                  modalMessage.textContent = '';
              });
              
          });
      });

       // Get the enable button and add an event
       const enableButton = document.querySelectorAll('.enable');
       enableButton.forEach(button => {
           button.addEventListener('click', async() => {
              modalChange.style.display = 'block';
              modalMessage.textContent = 'Are you sure do you want to enable this comment?';

              confirmBtn.addEventListener('click', async () => {
                  formData.append('type', 'enable');
                   const response = await editRequest(comments_url, button.dataset.id, formData, token);
                   if(response.status < 300) {
                      window.location.href = `navigate/comments.html?updated=${true}&message=${response.message}`;
                   } else {
                       console.error('Error deleting data:', response.message)
                   }
              });

              cancelBtn.addEventListener('click', () => {
                  modalChange.style.display = 'none';
                  modalMessage.textContent = '';
              });
               
           });
       });

       // Get the delete button and add an event
      const deleteButton = document.querySelectorAll('.delete')
      deleteButton.forEach(button => {
          button.addEventListener('click', () =>{
              modalChange.style.display = 'block';
              modalMessage.textContent = 'Are you sure do you want to delete this comment?';

              confirmBtn.addEventListener('click', async () => {
                  const response = await deleteRequest(comments_url, button.dataset.id, type, token);
                  if(response.status < 300) {
                      window.location.href = `navigate/comments.html?updated=${true}&message=${response.message}`;
                  } else {
                      console.error('Error deleting data:', response.message)
                  }
              });

              cancelBtn.addEventListener('click', () => {
                  modalChange.style.display = 'none';
                  modalMessage.textContent = '';
              });
          });
      })
  }

  const handleNoData = () => {
      const tableBody = document.querySelector('tbody');
      tableBody.innerHTML = `
          <tr>
              <td rowspan="7">No Comments Available</td>
          </tr>
      `;
  }

  const sortedComments = (comments) => {
      return comments.data.sort((a, b) => b.created_at - a.created_at)
  }

  const elipsisContent = (content) => {
      let elipsisText = ''
      elipsisText = content.length <= 15 ? content : content.substr(0, 30) + '...';
      return elipsisText;
  }

  const DateFormat = (date) => {
      const newDate = new Date(date);
      const dateFormat = newDate.toLocaleString('default', { month: 'short' }) + ' ' + newDate.getDate() + ' ' + newDate.getFullYear();
      return dateFormat;
  }

  if(comments && comments.status < 300){
      if (comments.data.length === 0) {
          handleNoData();
          return;
      }

      commentsTableData(sortedComments(comments))

      // Add pagination controls 
      const paginationContainer = document.querySelector('.pagination-comments'); 
      paginationContainer.innerHTML = ''; // Clear previous pagination

      // Create "Previous" button
      const prevButton = document.createElement('button');
      prevButton.textContent = 'Previous';
      prevButton.onclick = () => { 
          if (currentPage > 1) {
              currentPage--;
              fetchData(currentPage); 
          }
      };
      if (page === 1) {
          prevButton.disabled = true;
      }
      paginationContainer.appendChild(prevButton);

  
      const nextButton = document.createElement('button');
      nextButton.textContent = 'Next';
      nextButton.onclick = () => { 
          if (currentPage < totalPages) {
              currentPage++;
              fetchData(currentPage); 
          }
      };

      const totalPages = comments.totalPages; // Get total pages from API response

      if (currentPage === totalPages) { 
          nextButton.disabled = true;
      }
      paginationContainer.appendChild(nextButton);

      document.getElementById('pagination-number').innerHTML = `
          <h3>Page ${currentPage} of ${totalPages}</h3>
      `;
  }
  
}