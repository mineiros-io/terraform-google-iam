globals {
  supported_principals = [
    "allUsers",
    "allAuthenticatedUsers",
    "user",
    "serviceAccount",
    "group",
    "domain",
    "projectOwner",
    "projectEditor",
    "projectViewer",
  ]

  available_principles = {
    allUsers = {
      regex       = "^allAuthenticatedUsers$"
      pattern     = "allAuthenticatedUsers"
      description = "A special identifier that represents anyone who is on the internet; with or without a Google account."
    }
    allAuthenticatedUsers = {
      regex       = "^allAuthenticatedUsers$"
      pattern     = "allAuthenticatedUsers"
      description = "A special identifier that represents anyone who is authenticated with a Google account or a service account."
    }
    user = {
      regex       = "^user:"
      pattern     = "user:{emailid}"
      description = "An email address that represents a specific Google account."
      examples = [
        "user:alice@gmail.com",
        "user:joe@example.com",
      ]
    }
    serviceAccount = {
      regex       = "^serviceAccount:"
      pattern     = "serviceAccount:{emailid}"
      description = "An email address that represents a service account."
      examples = [
        "serviceAccount:my-other-app@appspot.gserviceaccount.com",
      ]
    }
    group = {
      regex       = "^group:"
      pattern     = "group:{emailid}"
      description = "An email address that represents a Google group."
      examples = [
        "group:developers@example.com",
        "group:admins@example.com",
      ]
    }
    domain = {
      regex       = "^domain:"
      pattern     = "domain:{domain}"
      description = "A G Suite domain (primary, instead of alias) name that represents all the users of that domain."
      examples = [
        "domain:google.com",
        "domain:example.com",
      ]
    }
    projectOwner = {
      regex       = "^projectOwner:"
      pattern     = "projectOwner:{projectid}"
      description = "Owners of the given Google Cloud Project."
      examples = [
        "projectOwner:my-example-project",
      ]
    }
    projectEditor = {
      regex       = "^projectEditor:"
      pattern     = "projectEditor:{projectid}"
      description = "Editors of the given project."
      examples = [
        "projectEditor:my-example-project",
      ]
    }
    projectViewer = {
      regex       = "^projectViewer:"
      pattern     = "projectViewer:{projectid}"
      description = "Viewers of the given project."
      examples =[
        "projectViewer:my-example-project",
      ]
    }
    computed = {
      regex       = "^computed:"
      pattern     = "computed:{identifier}"
      description = "An existing key from `var.computed_members_map`."
    }
    principal = {
      regex       = "^principal:"
      pattern     = "principal:{singleIdentity}"
      description = "Grants a role to the specified identity in a workload identity pool."
      documentation = [
        "https://cloud.google.com/iam/docs/workload-identity-federation",
      ]
    }
    principalSet = {
      regex       = "^principalSet:"
      pattern     = "principalSet:{setOfIdentities}"
      description = "Grants a role to all the identities in a workload identity pool, or to specific external identities based on their attributes."
      documentation = [
        "https://cloud.google.com/iam/docs/workload-identity-federation",
      ]
    }
  }
}
