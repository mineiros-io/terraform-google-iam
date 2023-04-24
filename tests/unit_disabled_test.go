package test

import (
	"fmt"
	"os"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestUnitDisabled(t *testing.T) {
	t.Parallel()

	test := "unit-disabled"

	terraformOptions := &terraform.Options{
		TerraformDir: fmt.Sprintf("../%s/tests/%s", os.Getenv("TM_STACK_PATH"), test),
		Upgrade:      true,
	}

	defer terraform.Destroy(t, terraformOptions)

	stdout := terraform.InitAndPlan(t, terraformOptions)

	resourceCount := terraform.GetResourceCount(t, stdout)
	assert.Equal(t, 0, resourceCount.Add, "No resources should have been planned to be created. Found %d instead.", resourceCount.Add)
	assert.Equal(t, 0, resourceCount.Change, "No resources should have been planned to be changed. Found %d instead.", resourceCount.Change)
	assert.Equal(t, 0, resourceCount.Destroy, "No resources should have been planned to be destroyed. Found %d instead.", resourceCount.Destroy)
}
